//
//  TodoDataFlow.swift
//
//
//  Created by MasakiShoji on 2024/03/06.
//

import Combine
import Common
import Domain
import Foundation
import UICore

public struct TodoDataFlow: DataFlow {
    public typealias UIState = State
    public typealias UIAction = Action
    public typealias UIStateProcessor = Processor

    @Observable
    public class State {
        var todos: [Todo]
        var showEditView: Bool = false
        var showActionSheet: Bool = false
        var selectedTodo: Todo? = nil

        public init(todos: [Todo]) {
            self.todos = todos
        }
    }

    public enum Action {
        public enum Lifecycle {
            case onLoad
        }

        public enum Callback {
            case fetchCompleted(todos: [Todo])
            case deleteCompleted
        }

        case lifecycle(Lifecycle)
        case callback(Callback)
        case addTodoButtonTapped
        case deleteIconTapped(todo: Todo)
        case dismissActionSheet
        case todoCellDeleted(todoId: UUID)
        case sheetVisibilityChanged(isPresented: Bool)
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
            case let .lifecycle(lifecycle):
                switch lifecycle {
                case .onLoad:
                    await fetchTodos { todos in
                        dispatch(.callback(.fetchCompleted(todos: todos)))
                    }
                }

            case .addTodoButtonTapped:
                state.showEditView = true
            case let .deleteIconTapped(todo):
                state.showActionSheet = true
                state.selectedTodo = todo
            case .dismissActionSheet:
                state.showActionSheet = false
                state.selectedTodo = nil
            case let .todoCellDeleted(todoId):
                await deleteTodo(todoId: todoId) { _ in
                    dispatch(.callback(.deleteCompleted))
                }
            case let .sheetVisibilityChanged(showEditView):
                state.showEditView = showEditView
                if !showEditView {
                    await fetchTodos { todos in
                        dispatch(.callback(.fetchCompleted(todos: todos)))
                    }
                }

            case let .callback(callback):
                switch callback {
                case let .fetchCompleted(todos):
                    state.todos = todos
                case .deleteCompleted:
                    state.showActionSheet = false
                    state.selectedTodo = nil
                    await fetchTodos { todos in
                        dispatch(.callback(.fetchCompleted(todos: todos)))
                    }
                }
            }
        }

        private func fetchTodos(receiveValue: @escaping (([Todo]) -> Void)) async {
            await todoRepository.fetchAll()
                .toAnyCancellableOnMain { [weak self] todos in
                    if self != nil {
                        receiveValue(todos)
                    }
                }
                .store(in: &cancellables)
        }

        private func deleteTodo(todoId: UUID, _ receiveValue: @escaping ((UUID) -> Void)) async {
            await todoRepository.delete(id: todoId).toAnyCancellableOnMain { [weak self] id in
                if self != nil {
                    receiveValue(id)
                }
            }
            .store(in: &cancellables)
        }
    }
}

public func mockTodoStore() -> Store<TodoDataFlow> {
    let todos = [
        Todo(
            task: "English exam",
            isCompleted: false
        ),
        Todo(
            task: "Math exam",
            isCompleted: false
        ),
    ]
    let state = TodoDataFlow.State(todos: todos)
    let repository = MockTodoRepository()
    let processor = TodoDataFlow.Processor(
        todoRepository: repository, cancellables: Set<AnyCancellable>()
    )
    return Store<TodoDataFlow>(state: state, processor: processor)
}
