//
//  ThingsView.swift
//  Meraki
//
//  Created by Christos Eteoglou on 2024-11-08.
//

import SwiftUI
import SwiftData

struct ThingsView: View {
    
    @Environment(\.modelContext) private var context
    @Query(filter: Day.currentDayPredicate(), sort: \.date) private var today: [Day]
    @Query(filter: #Predicate<Thing> { $0.isHidden == false }) private var things: [Thing]
    @State private var isPresented: Bool = false
    
    var body: some View {
        
        VStack (alignment: .leading, spacing: 20) {
            
            Text("Things")
                .font(.largeTitle)
                .bold()
            
            Text("These are the things that soothe your soul.")
            
            List (things) { thing in
                
                let today = getToday()
                
                HStack {
                    Text(thing.title)
                    Spacer()
                    
                    Button {
                        
                        if today.things.contains(thing) {
                            today.things.removeAll { t in t == thing}
                            try? context.save()
                        } else {
                            today.things.append(thing)
                        }
                        
                    } label: {
                        if today.things.contains(thing) {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundStyle(.green)
                        } else {
                            Image(systemName: "checkmark.circle")
                        }
                    }
                    
                }
            }
            .listStyle(.plain)
            
            Spacer()
            
            Button("Add New Thing") {
                // Show sheet to add thing
                isPresented.toggle()
            }
            .buttonStyle(.borderedProminent)
            .frame(maxWidth: .infinity, alignment: .center)
            
            Spacer()
        }
        .sheet(isPresented: $isPresented) {
            AddThingView()
                .presentationDetents([.fraction(0.2)])
        }
    }
    
    func getToday() -> Day {
        
        // Try to retrieve today from the database
        if today.count > 0 {
            return today.first!
        } else {
            // If it doesnt exist, create a day and insert it
            let today = Day()
            context.insert(today)
            try? context.save()
            
            return today
        }
    }
}

#Preview {
    ThingsView()
}
