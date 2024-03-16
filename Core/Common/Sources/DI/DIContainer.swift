//
//  DIContainer.swift
//  TodoTheSimplest
//
//  Created by MasakiShoji on 2024/02/25.
//

import Swinject

public final class DIContainer {
    public static let shared = DIContainer()

    var assemblies: [Assembly] = []

    public let container: Container = .init()

    private init() {}

    public func assemble(assemblies: [Assembly]) {
        _ = Assembler(
            assemblies,
            container: container
        )
    }

    public func register(dependencyGraph assemblies: [Assembly]) {
        assemble(assemblies: assemblies)
    }

    public func resolve<T>(_ serviceType: T.Type) -> T {
        guard let resolvedType = container.resolve(serviceType) else {
            fatalError()
        }
        return resolvedType
    }

    public func resolve<T>(_ serviceType: T.Type, registrationName: String?) -> T {
        guard let resolvedType = container.resolve(serviceType, name: registrationName) else {
            fatalError()
        }
        return resolvedType
    }

    public func resolve<T>(_ serviceType: T.Type, argument: some Any) -> T {
        guard let resolvedType = container.resolve(serviceType, argument: argument) else {
            fatalError()
        }
        return resolvedType
    }
}
