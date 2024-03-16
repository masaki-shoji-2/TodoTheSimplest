//
//  DatabaseAssembly.swift
//
//
//  Created by MasakiShoji on 2024/02/25.
//

import SwiftData
import Swinject

public final class DatabaseAssembly: Assembly {
    public func assemble(container: Container) {
        container.register(DataSource.self) { r in
            let container = r.resolve(ModelContainer.self)!
            return DataSourceImpl(container: container)
        }
    }
}
