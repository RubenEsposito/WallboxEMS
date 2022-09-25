//
//  QuasarDischargedWidget.swift
//  WallboxEMS
//
//  Created by Ruben Exposito Marin on 25/9/22.
//

import SwiftUI

struct QuasarDischargedWidget: View {
    
    @StateObject var viewModel: DashboardViewModel
    
    var body: some View {
        HStack {
            Text("Discharged from Quasar:")
            Spacer()
            Text(viewModel.energyDischargedFromQuasar)
        }.padding()
    }
}

struct QuasarDischargedWidget_Previews: PreviewProvider {
    
    static var previews: some View {
        QuasarDischargedWidget(viewModel: DashboardViewModel()
        )
    }
}
