//
//  ChartElement.swift
//  WallboxEMS
//
//  Created by Ruben Exposito Marin on 25/9/22.
//

import Foundation

struct ChartElement: Identifiable {
    let date: Date
    let power: kW
    let type: EnergySourceType
    var id: Date { return date }
}
