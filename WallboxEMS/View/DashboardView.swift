//
//  DashboardView.swift
//  WallboxEMS
//
//  Created by Ruben Exposito Marin on 24/9/22.
//

import SwiftUI

struct DashboardView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
