//
//  TodayView.swift
//  Meraki
//
//  Created by Christos Eteoglou on 2024-11-08.
//

import SwiftUI
import SwiftData

struct TodayView: View {
    
    @Environment(\.modelContext) private var context
    @Query(filter: Day.currentDayPredicate(), sort: \.date) private var today: [Day]
    
    var body: some View {
        
        VStack (spacing: 20) {
            
            Text("Today")
                .font(.largeTitle)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text("Try to do things today that make you feel positive today.")
                .frame(maxWidth: .infinity, alignment: .leading)
            
            // Only display the list if there are things done today
            if getToday().things.count > 0 {
                List(getToday().things ) { thing in
                    
                    Text(thing.title)
                }
                .listStyle(.plain)
            } else {
                // TODO: Display the image and some tooltips
            }
            
            Spacer()
        }
    }
    
    
    func getToday() -> Day {
        
        if today.count > 0 {
            return today.first!
        } else {
            let today = Day()
            context.insert(today)
            try? context.save()
            
            return today
        }
    }
}

#Preview {
    TodayView()
}
