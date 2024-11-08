//
//  HomeView.swift
//  Meraki
//
//  Created by Christos Eteoglou on 2024-11-08.
//

import SwiftUI

struct HomeView: View {
    @State private var selectedTab: Tab = .today

    var body: some View {
        TabView {
            ForEach(Tab.allCases, id: \.self) { tab in
                tab.view
                    .tabItem {
                        Text(tab.rawValue)
                        Image(systemName: tab.icon)
                    }
                    .tag(tab)
            }
        }
        .tint(.purple)
    }
}

#Preview {
    HomeView()
}
