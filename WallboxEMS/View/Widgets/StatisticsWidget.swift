//
//  StatisticsWidget.swift
//  WallboxEMS
//
//  Created by Ruben Exposito Marin on 25/9/22.
//

import SwiftUI

struct StatisticsWidget: View {
    
    var viewModel: HistoricalViewModel
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Gradient(colors: [.cyan.opacity(0.2), .white]))
                .ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 8, content: {
                Text("Statistics")
                    .font(.title2)
                Divider()
                HStack(alignment: .center, spacing: 8) {
                    Text(viewModel.gridTitle)
                    Spacer()
                    Text("\(viewModel.gridPercentageFormatted)%")
                        .bold()
                }
                HStack(alignment: .top, spacing: 8) {
                    Text(viewModel.solarTitle)
                    Spacer()
                    Text("\(viewModel.solarPercentageFormatted)%")
                        .bold()
                }
                HStack(alignment: .top, spacing: 8) {
                    Text(viewModel.quasarTitle)
                    Spacer()
                    Text("\(viewModel.quasarPercentageFormatted)%")
                        .bold()
                }
            })
            .padding()
        }
    }
}

struct StatisticsWidget_Previews: PreviewProvider {
    static var previews: some View {
        StatisticsWidget(viewModel: HistoricalViewModel(
            historical: [HistoricalData(
                buildingConsumption: 234,
                gridPower: 134,
                solarPower: 80,
                quasarsPower: -20,
                timestamp: ISO8601DateFormatter().date(from: "2021-09-27T15:48:00+00:00")!)]))
    }
}
