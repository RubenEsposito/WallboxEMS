//
//  HistoricalData.swift
//  WallboxEMS
//
//  Created by Ruben Exposito Marin on 24/9/22.
//

import Foundation

struct HistoricalData: Codable {
    
    let buildingConsumption: kW
    let gridPower: kW
    let solarPower: kW
    let quasarsPower: kW
    let timestamp: Date
    
    enum CodingKeys: String, CodingKey {
        case buildingConsumption = "building_active_power"
        case gridPower = "grid_active_power"
        case solarPower = "pv_active_power"
        case quasarsPower = "quasars_active_power"
        case timestamp
    }
}
