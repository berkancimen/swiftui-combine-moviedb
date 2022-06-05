//
//  HomeView.swift
//  OKR1 2022 Movie App
//
//  Created by Berkan Cimen on 24.04.2022.
//

import SwiftUI

struct HomeView: View {
    var body : some View {
        GeometryReader { g in
            // NavigationView
            NavigationView {
                // ScrollView
                ScrollView {
                    // VStack
                    VStack(alignment: .leading) {
                        HomeHeaderView(title: "Categories")
                    }
                    .navigationBarTitle("Home", displayMode: .large)
                }.background(Color("37_37_42"))
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
