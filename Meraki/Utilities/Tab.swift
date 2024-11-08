//
//  Tab.swift
//  Meraki
//
//  Created by Christos Eteoglou on 2024-11-08.
//

import Foundation
import SwiftUI

enum Tab: String, CaseIterable {
    case today = "Today"
    case things = "Things"
    case reminders = "Reminders"
    case settings = "Settings"
    
    var icon: String {
        switch self {
        case .today: return "calendar"
        case .things: return "heart"
        case .reminders: return "bell"
        case .settings: return "gear"
        }
    }
    
    var view: some View {
        switch self {
        case .today: return AnyView(TodayView())
        case .things: return AnyView(ThingsView())
        case .reminders: return AnyView(RemindersView())
        case .settings: return AnyView(SettingsView())
        }
    }
}
