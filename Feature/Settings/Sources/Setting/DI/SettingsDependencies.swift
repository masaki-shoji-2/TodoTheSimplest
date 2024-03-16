//
//  SettingsDependencies.swift
//
//
//  Created by MasakiShoji on 2024/02/25.
//

import Swinject

public enum SettingsDependencies {
    public static let dependencies: [Assembly] = [
        SettingsAssembly(),
    ]
}
