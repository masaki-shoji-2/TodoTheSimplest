//
//  TodoDependencies.swift
//
//
//  Created by MasakiShoji on 2024/02/25.
//

import Swinject

public enum TodoDependencies {
    public static let dependencies: [Assembly] = [
        TodoListAssembly(),
        TodoEditAssembly(),
        TodoDetailsAssembly(),
    ]
}
