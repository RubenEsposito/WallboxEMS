//
//  HistoricalViewModel.swift
//  WallboxEMS
//
//  Created by Ruben Exposito Marin on 25/9/22.
//

import Foundation
import Combine

enum EnergySourceType: String {
    case grid = "Grid"
    case solar = "Solar"
    case quasar = "Quasar"
    case buildingConsumption = "Building Consumption"
}

final class HistoricalViewModel: ObservableObject {
    
    struct Chart: Identifiable, Comparable {
        let date: Date
        let power: kW
        let type: EnergySourceType
        var id: Date { return date }
        
        static func <(lhs: Chart, rhs: Chart) -> Bool {
            return lhs.id < rhs.id
        }
    }
    
    // MARK: - Properties
    private var historical: [HistoricalData] = []
    
    
    // MARK: - Total statistics
    private var totalGrid: kW {
        guard !historical.isEmpty else { return 0.0 }
        return historical
            .map { $0.gridPower }
            .reduce(0, +)
    }
    private var totalSolar: kW {
        guard !historical.isEmpty else { return 0.0 }
        return historical
            .map { $0.solarPower }
            .reduce(0, +)
    }
    private var totalQuasar: kW {
        guard !historical.isEmpty else { return 0.0 }
        return historical
            .map { $0.quasarsPower }
            .reduce(0, +)
    }
    private var totalBuildingDemand: kW {
        guard !historical.isEmpty else { return 0.0 }
        return historical
            .map { $0.buildingConsumption }
            .reduce(0, +)
    }
    private var gridPercentage: Percent {
        guard !historical.isEmpty else { return 0.0 }
        return (totalGrid*100) / totalBuildingDemand
    }
    private var solarPercentage: Percent {
        guard !historical.isEmpty else { return 0.0 }
        return (totalSolar*100) / totalBuildingDemand
    }
    private var quasarPercentage: Percent {
        guard !historical.isEmpty, totalQuasar < 0 else { return 0.0 }
        return (abs(totalQuasar)*100) / totalBuildingDemand
    }
    
    var gridTitle: String { return "Grid" }
    var solarTitle: String { return "Solar" }
    var quasarTitle: String { return "Quasar" }
    
    var gridPercentageFormatted: String { return String(format: "%.1f", gridPercentage) }
    var solarPercentageFormatted: String { return String(format: "%.1f", solarPercentage) }
    var quasarPercentageFormatted: String { return String(format: "%.1f", quasarPercentage) }
    
    var charts: [Chart] {
        let gridCharts = historical
            .map { return Chart(date: $0.timestamp, power: $0.gridPower, type: .grid) }
            .sorted(by: { $0.date < $1.date })
        
        let solarCharts = historical
            .map { return Chart(date: $0.timestamp, power: $0.solarPower, type: .solar) }
            .sorted(by: { $0.date < $1.date })
        
        // Invert the power from Quasar so it's easier to compare with the other power sources
        let quasarCharts = historical
            .map { return Chart(date: $0.timestamp, power: -$0.quasarsPower, type: .quasar) }
            .sorted(by: { $0.date < $1.date })
        
        let buildingConsumptionCharts = historical
            .map { return Chart(date: $0.timestamp, power: $0.gridPower + $0.solarPower - $0.quasarsPower, type: .buildingConsumption) }
            .sorted(by: { $0.date < $1.date })
        
        return gridCharts + solarCharts + quasarCharts + buildingConsumptionCharts
    }
    
    // MARK: - Constructor
    init(historical: [HistoricalData]) {
        self.historical = historical
    }
    
}
