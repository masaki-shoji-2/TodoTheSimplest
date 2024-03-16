//
//  View+Extensions.swift
//
//
//  Created by MasakiShoji on 2024/03/16.
//

import SwiftUI

public extension View {
    func onLoad(perform action: (() -> Void)? = nil) -> some View {
        modifier(ViewDidLoadModifier(perform: action))
    }
}
