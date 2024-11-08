//
//  GlobalBackgroundModifier.swift
//  Meraki
//
//  Created by Christos Eteoglou on 2024-11-08.
//

import Foundation
import SwiftUI

struct GlobalBackgroundModifier: ViewModifier {
    func body(content: Content) -> some View {
        content.background(Color.yellow)
            .ignoresSafeArea()
    }
}

extension View {
    func globalBackground() -> some View {
        self.modifier(GlobalBackgroundModifier())
    }
}
