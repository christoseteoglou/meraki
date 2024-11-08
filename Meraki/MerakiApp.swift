//
//  MerakiApp.swift
//  Meraki
//
//  Created by Christos Eteoglou on 2024-11-08.
//

import SwiftUI
import SwiftData

@main
struct MerakiApp: App {
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .modelContainer(for: [Day.self, Thing.self])
        }
    }
}
