//
//  RepositoryDependencies.swift
//
//
//  Created by MasakiShoji on 2024/02/25.
//

import Swinject

public enum RepositoryDependencies {
    public static let dependencies: [Assembly] = [
        RepositoryAssembly(),
    ]
}
