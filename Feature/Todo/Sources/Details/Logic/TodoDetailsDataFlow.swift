//
//  TodoDetailsDataFlow.swift
//
//
//  Created by MasakiShoji on 2024/03/06.
//

import Combine
import Common
import Domain
import Foundation
import UICore

public struct TodoDetailsDataFlow: DataFlow {
    public typealias UIState = State
    public typealias UIAction = Action
    public typealias UIStateProcessor = Processor

    @Observable
    public class State {
        var todo: Todo

        public init(
            todo: Todo = Todo.empty()
        ) {
            self.todo = todo
        }
    }

    public enum Action {
        case none
    }

    public class Processor: StateProcessor {
        public typealias UIState = State
        public typealias UIAction = Action

        public init() {}

        public func process(
            state _: State,
            action _: Action,
            dispatch _: @escaping Dispatch<Action>
        ) async {
            // does nothing for now.
        }
    }
}

public func mockTodoDetailsStore(todo: Todo = Todo.empty()) -> Store<TodoDetailsDataFlow> {
    let state = TodoDetailsDataFlow.State(todo: todo)
    let processor = TodoDetailsDataFlow.Processor()
    return Store<TodoDetailsDataFlow>(state: state, processor: processor)
}
