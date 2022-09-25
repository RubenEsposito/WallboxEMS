//
//  QuasarChargedWidget.swift
//  WallboxEMS
//
//  Created by Ruben Exposito Marin on 25/9/22.
//

import SwiftUI

struct QuasarChargedWidget: View {
    
    @StateObject var viewModel: DashboardViewModel
    
    var body: some View {
        HStack {
            Text("Charged with Quasar:")
            Spacer()
            Text(viewModel.energyChargedFromQuasar)
        }.padding()
    }
}

struct QuasarChargedWidget_Previews: PreviewProvider {
    
    static var previews: some View {
        QuasarChargedWidget(viewModel: DashboardViewModel()
        )
    }
}
