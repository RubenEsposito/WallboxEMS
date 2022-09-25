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

final class DashboardViewModel: ObservableObject {
    
    // MARK: - Properties
    private var queue: DispatchQueue = .main
    private var cancellables: [AnyCancellable] = []
    private var liveService: LiveDataServiceProtocol
    private var historicalService: HistoricalDataServiceProtocol
    private var error: WallboxError?
    private var energyCharged: kW {
        didSet {
            energyChargedFromQuasar = "\(String(format: "%.1f", abs(energyCharged))) kWh"
        }
    }
    private var energyDischarged: kW {
        didSet {
            energyDischargedFromQuasar = "\(String(format: "%.1f", abs(energyDischarged))) kWh"
        }
    }
    
    var errorDescription: String { return error?.localizedDescription ?? "Something went wrong" }
    
    // MARK: - Published
    @Published var isError: Bool = false
    @Published var energyChargedFromQuasar: String = "kWh"
    @Published var energyDischargedFromQuasar: String = "kWh"
    @Published var live: LiveData?
    @Published var historical: [HistoricalData] = []
    
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
    
    // MARK: - Data
    func refresh(on: DispatchQueue = DispatchQueue.main) {
        self.queue = on
        fetchLive()
        fetchHistorical()
        self.isError = false
    }
    
    private func fetchLive() {
        liveService.fetchLive()
            .receive(on: queue)
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
                self.live = response
            }.store(in: &cancellables)
    }
    
    private func fetchHistorical() {
        historicalService.fetchHistorical()
            .receive(on: queue)
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
                self.historical = response
                self.energyCharged = self.historical
                    .filter{ $0.quasarsPower >= 0 }
                    .map(\.quasarsPower)
                    .reduce(0, +)
                self.energyDischarged = self.historical
                    .filter{ $0.quasarsPower < 0 }
                    .map(\.quasarsPower)
                    .reduce(0, +)
            }.store(in: &cancellables)
    }
    
}
