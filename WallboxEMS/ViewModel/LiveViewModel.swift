//
//  LiveViewModel.swift
//  WallboxEMS
//
//  Created by Ruben Exposito Marin on 25/9/22.
//

import Foundation

final class LiveViewModel {
    // MARK: - Properties
    private var live: LiveData?
    
    // MARK: - Data
    var solar: String { return "\(String(format: "%.2f", live?.solarPower ?? 0.0)) kWh" }
    var quasars: String { return "\(String(format: "%.2f", live?.quasarsPower ?? 0.0)) kWh" }
    var grid: String { return "\(String(format: "%.2f", live?.gridPower ?? 0.0)) kWh" }
    var demand: String { return "\(String(format: "%.2f", live?.buildingConsumption ?? 0.0)) kWh" }
    
    // MARK: - Constructor
    init(live: LiveData?) {
        self.live = live
    }
}
