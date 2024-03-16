//
//  HomeView.swift
//
//  Created by MasakiShoji on 2024/02/25.
//

import Common
import Settings
import SwiftUI
import Todo
import UICore

public struct HomeView: View {
    let navigator: Navigator
    let todoListView: AnyView
    let settingsView: AnyView

    public init(
        navigator: Navigator,
        todoListView: AnyView,
        settingsView: AnyView
    ) {
        self.navigator = navigator
        self.todoListView = todoListView
        self.settingsView = settingsView
    }

    public var body: some View {
        TabView {
            todoListView
                .tabItem {
                    Label(
                        "ToDo".localized(.module),
                        systemImage: "checkmark.bubble"
                    )
                }
            settingsView
                .tabItem {
                    Label(
                        "Settings".localized(.module),
                        systemImage: "person.crop.circle.fill"
                    )
                }
        }
    }
}

#Preview {
    HomeView(
        navigator: MockNavigator(),
        todoListView: AnyView(Text("ToDo")),
        settingsView: AnyView(Text("Settings"))
    )
}
