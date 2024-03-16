//
//  AppNavigator.swift
//  TodoTheSimplest
//
//  Created by MasakiShoji on 2024/02/23.
//

import Common
import Settings
import SwiftUI
import Todo
import UICore

struct AppNavigator: Navigator {
    func navigate(_ destination: Destination) -> AnyView {
        AnyView(destination.toView())
    }
}

private extension Destination {
    func toView() -> any View {
        switch self {
        case let .todo(todo):
            switch todo {
            case .list:
                DIContainer.shared.resolve(TodoListView.self)
            case let .detail(todo):
                DIContainer.shared.resolve(TodoDetailsView.self, argument: todo)
            case let .edit(todo):
                DIContainer.shared.resolve(TodoEditView.self, argument: todo)
            }
        case .settings:
            DIContainer.shared.resolve(SettingsView.self)
        }
    }
}
