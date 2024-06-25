//
//  ContentView.swift
//  BBQuotes17
//
//  Created by Morgyn Peay on 6/18/24.
//

import SwiftUI

struct MainPage: View {
    var body: some View {
        TabView {
            FetchView(show: Constants.bbName)
                .toolbarBackground(.visible, for: .tabBar)
                .tabItem {
                    Label(Constants.bbName, systemImage: "tortoise")
                }
            
            FetchView(show: Constants.bcsName)
                .toolbarBackground(.visible, for: .tabBar)
                .tabItem {
                    Label(Constants.bcsName, systemImage: "briefcase")
                }
            
            FetchView(show: Constants.ecName)
                .toolbarBackground(.visible, for: .tabBar)
                .tabItem {
                    Label(Constants.ecName, systemImage: "car")
                }
        }
        .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    MainPage()
}
