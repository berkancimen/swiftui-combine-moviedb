//
//  ContentView.swift
//  OKR1 2022 Movie App
//
//  Created by Berkan Cimen on 23.04.2022.
//

import SwiftUI

struct ContentView: View {
    
    let coloredNavAppearance = UINavigationBarAppearance()
    @State private var selection = 0
    
    init() {
        
        UITabBar.appearance().barTintColor = UIColor(named : "40_40_40")
        UITabBar.appearance().tintColor = UIColor.white
        UITabBar.appearance().backgroundColor = UIColor(named : "60_60_60")
        
        coloredNavAppearance.configureWithOpaqueBackground()
        coloredNavAppearance.backgroundColor = UIColor(named : "37_37_42")
        coloredNavAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        coloredNavAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]

        UINavigationBar.appearance().standardAppearance = coloredNavAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredNavAppearance
    }
    
    var body : some View {
        ZStack{
            UIKitTabView([
                UIKitTabView.Tab(
                    view: HomeView(),
                    barItem: UITabBarItem(title: "", image: UIImage(named: "barHome"), selectedImage: UIImage(named: "barHomeSelect"))
                ),
                UIKitTabView.Tab(
                    view: SearchView(),
                    barItem: UITabBarItem(title: "", image: UIImage(named: "barSearch"), selectedImage: UIImage(named: "barSearchSelect"))
                )
            ])
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
