//
//  DetailView.swift
//  WallboxEMS
//
//  Created by Ruben Exposito Marin on 25/9/22.
//

import SwiftUI
import Charts

struct DetailView: View {
    
    var viewModel: HistoricalViewModel
    
    var body: some View {
        List {
            Chart {
                ForEach(viewModel.charts) {
                    LineMark(
                        x: .value("Time", $0.date),
                        y: .value("kW", $0.power)
                    )
                    .foregroundStyle(by: .value("Type", "\($0.type.rawValue)"))
                }
            }
            .frame(height: 600)
        }
        .navigationBarTitle("Statistics", displayMode: .inline)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(viewModel: HistoricalViewModel(
            historical: [HistoricalData(
                buildingConsumption: 234,
                gridPower: 134,
                solarPower: 80,
                quasarsPower: -20,
                timestamp: ISO8601DateFormatter().date(from: "2021-09-27T15:48:00+00:00")!)]))
    }
}
