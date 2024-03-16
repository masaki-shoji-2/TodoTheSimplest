//
//  HomeAssembly.swift
//
//
//  Created by MasakiShoji on 2024/02/25.
//

import Settings
import SwiftUI
import Swinject
import Todo
import UICore

public final class HomeAssembly: Assembly {
    public func assemble(container: Container) {
        container.register(HomeView.self) { r in
            let navigator = r.resolve(Navigator.self)!
            let todoListView = r.resolve(TodoListView.self)!
            let settingsView = r.resolve(SettingsView.self)!
            return .init(
                navigator: navigator,
                todoListView: AnyView(todoListView),
                settingsView: AnyView(settingsView)
            )
        }
    }
}
