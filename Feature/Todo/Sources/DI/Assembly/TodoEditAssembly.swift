//
//  TodoEditAssembly.swift
//
//
//  Created by MasakiShoji on 2024/02/25.
//

import Combine
import Domain
import Swinject
import UICore

public final class TodoEditAssembly: Assembly {
    public func assemble(container: Container) {
        container.register(TodoEditDataFlow.Processor.self) { r in
            let repository = r.resolve(TodoRepository.self)!
            let cancellables = Set<AnyCancellable>()
            return .init(todoRepository: repository, cancellables: cancellables)
        }

        container.register(Store<TodoEditDataFlow>.self, name: "todoEditStore") { r, todo in
            let state = TodoEditDataFlow.State(todo: todo)
            let processor = r.resolve(TodoEditDataFlow.Processor.self)!
            return .init(state: state, processor: processor)
        }

        container.register(TodoEditView.self) { r, todo in
            let store = r.resolve(Store<TodoEditDataFlow>.self, name: "todoEditStore", argument: todo as Todo)!
            return TodoEditView(store: store)
        }
    }
}
