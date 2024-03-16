//
//  RepositoryAssembly.swift
//
//
//  Created by MasakiShoji on 2024/02/25.
//

import Database
import Domain
import SwiftData
import Swinject

public final class RepositoryAssembly: Assembly {
    public func assemble(container: Container) {
        container.register(TodoRepository.self) { r in
            let dataSource = r.resolve(DataSource.self)!
            return TodoRepositoryImpl(dataSource: dataSource)
        }
    }
}
