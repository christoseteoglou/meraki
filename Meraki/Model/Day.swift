//
//  Day.swift
//  Meraki
//
//  Created by Christos Eteoglou on 2024-11-08.
//

import Foundation
import SwiftData

@Model
class Day : Identifiable {
    var id: String = UUID().uuidString
    var date: Date = Date()
    var things = [Thing]()
    
    init() {
        
    }
}

extension Day {
    
    static func currentDayPredicate() -> Predicate<Day> {
        
        let calendar = Calendar.autoupdatingCurrent
        let start = calendar.startOfDay(for: Date.now)
        
        return #Predicate<Day> { $0.date >= start }
    }
}
