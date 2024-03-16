//
//  DatabaseDependencies.swift
//
//
//  Created by MasakiShoji on 2024/02/25.
//

import Swinject

public enum DatabaseDependencies {
    public static let dependencies: [Assembly] = [
        DatabaseAssembly(),
    ]
}
