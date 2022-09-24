//
//  HistoricalData.swift
//  WallboxEMS
//
//  Created by Ruben Exposito Marin on 24/9/22.
//

import Foundation

typealias KW = Double
typealias percent = Double

struct HistoricalData: Codable {
    
    let buildingConsumption: KW
    let powerFromGrid: KW
    let powerFromSolarPanels: KW
    let powerFromQuasars: KW
    let timeStamp: String
    
    enum CodingKeys: String, CodingKey {
        case buildingConsumption = "building_active_power"
        case powerFromGrid = "grid_active_power"
        case powerFromSolarPanels = "pv_active_power"
        case powerFromQuasars = "quasars_active_power"
        case timeStamp
    }
}
