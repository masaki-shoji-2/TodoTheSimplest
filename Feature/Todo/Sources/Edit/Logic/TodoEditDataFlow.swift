//
//  TodoEditDataFlow.swift
//
//
//  Created by MasakiShoji on 2024/03/06.
//

import Combine
import Common
import Domain
import Foundation
import UICore

public struct TodoEditDataFlow: DataFlow {
    public typealias UIState = State
    public typealias UIAction = Action
    public typealias UIStateProcessor = Processor

    @Observable
    public class State {
        var todo: Todo
        var dismiss: Bool = false

        public init(
            todo: Todo = Todo.empty()
        ) {
            self.todo = todo
        }
    }

    public enum Action {
        public enum Callback {
            case insertCompleted
        }

        case callback(Callback)
        case textInput(text: String)
        case addButtonTapped
    }

    public class Processor: StateProcessor {
        public typealias UIState = State
        public typealias UIAction = Action

        private let todoRepository: TodoRepository
        private var cancellables: Set<AnyCancellable>

        public init(
            todoRepository: TodoRepository,
            cancellables: Set<AnyCancellable> = Set<AnyCancellable>()
        ) {
            self.todoRepository = todoRepository
            self.cancellables = cancellables
        }

        public func process(
            state: State,
            action: Action,
            dispatch: @escaping Dispatch<Action>
        ) async {
            switch action {
            case let .callback(callback):
                switch callback {
                case .insertCompleted:
                    state.dismiss = true
                }
            case let .textInput(text):
                state.todo.task = text
            case .addButtonTapped:
                await insertTodo(state.todo) {
                    dispatch(.callback(.insertCompleted))
                }
            }
        }

        private func insertTodo(_ todo: Todo, _ receiveValue: @escaping (() -> Void)) async {
            await todoRepository.insert(todo)
                .toAnyCancellableOnMain { [weak self] _ in
                    if self != nil {
                        receiveValue()
                    }
                }
                .store(in: &cancellables)
        }
    }
}

public func mockTodoEditStore() -> Store<TodoEditDataFlow> {
    let state = TodoEditDataFlow.State(todo: Todo.empty())
    let repository = MockTodoRepository()
    let processor = TodoEditDataFlow.Processor(
        todoRepository: repository, cancellables: Set<AnyCancellable>()
    )
    return Store<TodoEditDataFlow>(state: state, processor: processor)
}
