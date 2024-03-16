//
//  TodoListAssembly.swift
//
//
//  Created by MasakiShoji on 2024/02/25.
//

import Combine
import Common
import Domain
import Swinject
import UICore

public final class TodoListAssembly: Assembly {
    public func assemble(container: Container) {
        container.register(TodoDataFlow.State.self) { _ in
            .init(todos: [])
        }

        container.register(TodoDataFlow.Processor.self) { r in
            let repository = r.resolve(TodoRepository.self)!
            let cancellables = Set<AnyCancellable>()
            return .init(todoRepository: repository, cancellables: cancellables)
        }

        container.register(Store<TodoDataFlow>.self, name: "todoStore") { r in
            let state = r.resolve(TodoDataFlow.State.self)!
            let processor = r.resolve(TodoDataFlow.Processor.self)!
            return .init(state: state, processor: processor)
        }

        container.register(TodoListView.self) { r in
            let navigator = r.resolve(Navigator.self)!
            let store = r.resolve(Store<TodoDataFlow>.self, name: "todoStore")!
            return TodoListView(navigator: navigator, store: store)
        }
    }
}
