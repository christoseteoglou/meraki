//
//  Thing.swift
//  Meraki
//
//  Created by Christos Eteoglou on 2024-11-08.
//

import Foundation
import SwiftData

@Model
class Thing: Identifiable {
    var id: String = UUID().uuidString
    var title: String = ""
    var lastUpdated: Date = Date()
    var isHidden: Bool = false
    
    init(title: String) {
        self.title = title
    }
}
