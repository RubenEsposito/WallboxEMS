//
//  DashboardView.swift
//  WallboxEMS
//
//  Created by Ruben Exposito Marin on 24/9/22.
//

import SwiftUI

struct DashboardView: View {
    
    @StateObject var viewModel = DashboardViewModel()

    var body: some View {
        NavigationView {
            ZStack {
                VStack(alignment: .leading, spacing: 0) {
                    ScrollView{
                        QuasarDischargedWidget(viewModel: viewModel)
                        QuasarChargedWidget(viewModel: viewModel)
                        LiveWidget(viewModel: viewModel)
                        NavigationLink(destination: DetailView(viewModel: viewModel)) {
                            StatisticsWidget(viewModel: viewModel)
                        }
                    }
                    .padding()
                    .navigationBarTitle("Dashboard", displayMode: .inline)
                }
            }
        }
        .onAppear {
            viewModel.refresh()
        }
        .alert(isPresented: $viewModel.isError) {
            Alert(title: Text("Error"),
                  message: Text(viewModel.errorDescription),
                  dismissButton: .default(Text("Accept")))
        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
