//
//  ChartElement.swift
//  WallboxEMS
//
//  Created by Ruben Exposito Marin on 25/9/22.
//

import Foundation

struct ChartElement: Identifiable, Equatable {
    let date: Date
    let power: kW
    let type: EnergySourceType
    var id: Date { return date }
    
    static func ==(lhs: ChartElement, rhs: ChartElement) -> Bool {
        return lhs.date == rhs.date && lhs.power == rhs.power && lhs.type == rhs.type
    }
}
