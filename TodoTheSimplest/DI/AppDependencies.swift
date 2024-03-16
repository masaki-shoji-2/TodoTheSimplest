//
//  AppDependencies.swift
//  TodoTheSimplest
//
//  Created by MasakiShoji on 2024/02/25.
//

import Database
import Home
import Repository
import Settings
import Swinject
import Todo
import UICore

enum AppDependencies {
    static let dependencies: [Assembly] = [
        AppAssembly(),
    ]

    static let dependencyGraph: [Assembly] = [
        AppDependencies.dependencies,
        HomeDependencies.dependencies,
        UICoreDependencies.dependencies,
        TodoDependencies.dependencies,
        SettingsDependencies.dependencies,
        DatabaseDependencies.dependencies,
        RepositoryDependencies.dependencies,
    ].reduce([], (+))
}
