//
//  LiveWidget.swift
//  WallboxEMS
//
//  Created by Ruben Exposito Marin on 25/9/22.
//

import SwiftUI

struct LiveWidget: View {
    
    var viewModel: LiveViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8, content: {
            Text("Live data")
                .font(.title2)
            Divider()
            HStack(alignment: .center, spacing: 8) {
                Text("Grid")
                Spacer()
                Text(viewModel.grid)
                    .bold()
            }
            HStack(alignment: .center, spacing: 8) {
                Text("Solar")
                Spacer()
                Text(viewModel.solar)
                    .bold()
            }
            HStack(alignment: .center, spacing: 8) {
                Text("Quasar")
                Spacer()
                Text(viewModel.quasars)
                    .bold()
            }
            HStack(alignment: .center, spacing: 8) {
                Text("Building consumption")
                Spacer()
                Text(viewModel.demand)
                    .bold()
            }
        })
        .padding()
    }
}

struct LiveWidget_Previews: PreviewProvider {
    
    static var previews: some View {
        LiveWidget(viewModel: LiveViewModel(
            live: LiveData(
                buildingConsumption: 104.0,
                gridPower: 24.0,
                solarPower: 24.0,
                quasarsPower: 24.0,
                systemSoc: 23,
                totalEnergy: 200,
                currentEnergy: 123)
            )
        )
    }
}
