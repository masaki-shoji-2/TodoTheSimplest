//
//  TodoDetailsAssembly.swift
//
//
//  Created by MasakiShoji on 2024/02/25.
//

import Combine
import Domain
import Swinject
import UICore

public final class TodoDetailsAssembly: Assembly {
    public func assemble(container: Container) {
        container.register(TodoDetailsDataFlow.Processor.self) { _ in
            .init()
        }

        container.register(Store<TodoDetailsDataFlow>.self, name: "todoDetailsStore") { r, todo in
            let state = TodoDetailsDataFlow.State(todo: todo)
            let processor = r.resolve(TodoDetailsDataFlow.Processor.self)!
            return .init(state: state, processor: processor)
        }

        container.register(TodoDetailsView.self) { r, todo in
            let store = r.resolve(Store<TodoDetailsDataFlow>.self, name: "todoDetailsStore", argument: todo as Todo)!
            return TodoDetailsView(store: store)
        }
    }
}
