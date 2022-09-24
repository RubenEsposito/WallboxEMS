//
//  LiveData.swift
//  WallboxEMS
//
//  Created by Ruben Exposito Marin on 24/9/22.
//

import Foundation

typealias kW = Double
typealias kWh = Double
typealias Percent = Double

struct LiveData: Codable {
    
    let buildingConsumption: kW
    let gridPower: kW
    let solarPower: kW
    let quasarsPower: kW
    let systemSoc: Percent
    let totalEnergy: kWh
    let currentEnergy: kWh

    enum CodingKeys: String, CodingKey {
        case solarPower = "solar_power"
        case quasarsPower = "quasars_power"
        case gridPower = "grid_power"
        case buildingConsumption = "building_demand"
        case systemSoc = "system_soc"
        case totalEnergy = "total_energy"
        case currentEnergy = "current_energy"
    }
}
