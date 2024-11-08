//
//  LongPressEasterEggModifier.swift
//  Meraki
//
//  Created by Christos Eteoglou on 2024-11-08.
//

import Foundation
import SwiftUI

struct LongPressEasterEggModifier: ViewModifier {
    @State private var showEasterEgg = false

    func body(content: Content) -> some View {
        content
            .onLongPressGesture(minimumDuration: 2) {
                showEasterEgg = true
            }
            .alert("🎉 Freeze!", isPresented: $showEasterEgg) {
                Button("OK") { showEasterEgg = false }
            } message: {
                Text("Wait... what was I supposed to be doing again?")
            }
    }
}

extension View {
    func globalLongPressEasterEgg() -> some View {
        self.modifier(LongPressEasterEggModifier())
    }
}
