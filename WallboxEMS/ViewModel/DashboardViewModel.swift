//
//  DashboardViewModel.swift
//  WallboxEMS
//
//  Created by Ruben Exposito Marin on 25/9/22.
//

import Foundation
import Combine

enum DashboardStatus {
    case loading
    case finished
    case error
}

enum EnergySourceType: String {
    case grid = "Grid"
    case solar = "Solar"
    case quasar = "Quasar"
    case buildingConsumption = "Building Consumption"
}

final class DashboardViewModel: ObservableObject {
    
    // MARK: - Published
    @Published var isError: Bool = false
    @Published var energyChargedFromQuasar: String = "kWh"
    @Published var energyDischargedFromQuasar: String = "kWh"
    @Published var liveData: LiveData?
    @Published var historicalData: [HistoricalData] = []
    
    // MARK: - Properties
    
    // Networking
    var errorDescription: String { return error?.localizedDescription ?? "Something went wrong" }
    private var cancellables: [AnyCancellable] = []
    private var liveService: LiveDataServiceProtocol
    private var historicalService: HistoricalDataServiceProtocol
    private var error: WallboxError?
    
    // Quasar charged/discharged energy
    private var energyCharged: kW {
        didSet {
            energyChargedFromQuasar = "\(String(format: "%.2f", abs(energyCharged))) kWh"
        }
    }
    private var energyDischarged: kW {
        didSet {
            energyDischargedFromQuasar = "\(String(format: "%.2f", abs(energyDischarged))) kWh"
        }
    }
    
    // Live Data
    var solar: String { return "\(String(format: "%.2f", liveData?.solarPower ?? 0.0)) kWh" }
    var quasars: String { return "\(String(format: "%.2f", liveData?.quasarsPower ?? 0.0)) kWh" }
    var grid: String { return "\(String(format: "%.2f", liveData?.gridPower ?? 0.0)) kWh" }
    var demand: String { return "\(String(format: "%.2f", liveData?.buildingConsumption ?? 0.0)) kWh" }
    
    // Statistics Data
    private var totalGrid: kW {
        guard !historicalData.isEmpty else { return 0.0 }
        return historicalData
            .map { $0.gridPower }
            .reduce(0, +)
    }
    private var totalSolar: kW {
        guard !historicalData.isEmpty else { return 0.0 }
        return historicalData
            .map { $0.solarPower }
            .reduce(0, +)
    }
    private var totalQuasar: kW {
        guard !historicalData.isEmpty else { return 0.0 }
        return historicalData
            .map { $0.quasarsPower }
            .reduce(0, +)
    }
    private var totalBuildingDemand: kW {
        guard !historicalData.isEmpty else { return 0.0 }
        return historicalData
            .map { $0.buildingConsumption }
            .reduce(0, +)
    }
    private var gridPercentage: Percent {
        guard !historicalData.isEmpty else { return 0.0 }
        return (totalGrid*100) / totalBuildingDemand
    }
    private var solarPercentage: Percent {
        guard !historicalData.isEmpty else { return 0.0 }
        return (totalSolar*100) / totalBuildingDemand
    }
    private var quasarPercentage: Percent {
        guard !historicalData.isEmpty, totalQuasar < 0 else { return 0.0 }
        return (abs(totalQuasar)*100) / totalBuildingDemand
    }
    
    var gridTitle: String { return "Grid" }
    var solarTitle: String { return "Solar" }
    var quasarTitle: String { return "Quasar" }
    
    var gridPercentageFormatted: String { return String(format: "%.1f", gridPercentage) }
    var solarPercentageFormatted: String { return String(format: "%.1f", solarPercentage) }
    var quasarPercentageFormatted: String { return String(format: "%.1f", quasarPercentage) }
    
    // Charts data
    var charts: [ChartElement] {
        let gridCharts = historicalData
            .map { return ChartElement(date: $0.timestamp, power: $0.gridPower, type: .grid) }
            .sorted(by: { $0.date < $1.date })
        
        let solarCharts = historicalData
            .map { return ChartElement(date: $0.timestamp, power: $0.solarPower, type: .solar) }
            .sorted(by: { $0.date < $1.date })
        
        // Invert the power from Quasar so it's easier to compare with the other power sources
        let quasarCharts = historicalData
            .map { return ChartElement(date: $0.timestamp, power: -$0.quasarsPower, type: .quasar) }
            .sorted(by: { $0.date < $1.date })
        
        let buildingConsumptionCharts = historicalData
            .map { return ChartElement(date: $0.timestamp, power: $0.buildingConsumption, type: .buildingConsumption) }
            .sorted(by: { $0.date < $1.date })
        
        return gridCharts + solarCharts + quasarCharts + buildingConsumptionCharts
    }
    
    // MARK: - Life cycle
    init(live: LiveDataServiceProtocol = LiveDataServiceMock(), historical: HistoricalDataServiceProtocol = HistoricalDataServiceMock()) {
        liveService = live
        historicalService = historical
        energyCharged = 0.0
        energyDischarged = 0.0
    }
    
    deinit {
        cancellables.forEach{ $0.cancel() }
        cancellables.removeAll()
    }
    
    // MARK: - Interactor
    func refresh() {
        fetchLive()
        fetchHistorical()
        self.isError = false
    }
    
    private func fetchLive() {
        liveService.fetchLive()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self else { return }
                switch completion {
                case.failure(let error):
                    self.error = error as? WallboxError
                    self.isError = true
                case .finished: break
                    
                }
            } receiveValue: { [weak self] (response: LiveData) in
                guard let self else { return }
                self.liveData = response
            }.store(in: &cancellables)
    }
    
    private func fetchHistorical() {
        historicalService.fetchHistorical()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self else { return }
                switch completion {
                case.failure(let error):
                    self.error = error as? WallboxError
                    self.isError = true
                case .finished: break
                }
            } receiveValue: { [weak self] (response: [HistoricalData]) in
                guard let self else { return }
                self.historicalData = response
                self.energyCharged = self.historicalData
                    .filter{ $0.quasarsPower >= 0 }
                    .map(\.quasarsPower)
                    .reduce(0, +)
                self.energyDischarged = self.historicalData
                    .filter{ $0.quasarsPower < 0 }
                    .map(\.quasarsPower)
                    .reduce(0, +)
            }.store(in: &cancellables)
    }
    
}
