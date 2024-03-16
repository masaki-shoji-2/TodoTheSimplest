//
//  TodoTheSimplestApp.swift
//  TodoTheSimplest
//
//  Created by MasakiShoji on 2024/02/22.
//

import Common
import Home
import SwiftUI
import Swinject
import Todo
import UICore

@main
struct TodoTheSimplestApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    let homeView: HomeView
    let appConfig: AppConfig

    init() {
        DIContainer.shared.register(dependencyGraph: AppDependencies.dependencyGraph)
        homeView = DIContainer.shared.resolve(HomeView.self)
        appConfig = DIContainer.shared.resolve(AppConfig.self)

        print("\(appConfig.description)")
    }

    var body: some Scene {
        WindowGroup {
            homeView
        }
    }
}
