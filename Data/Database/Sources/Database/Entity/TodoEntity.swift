//
//  TodoEntity.swift
//
//
//  Created by MasakiShoji on 2024/03/02.
//

import Domain
import Foundation
import SwiftData

@Model
public class TodoEntity: Entity, Identifiable {
    public let id: UUID
    public var task: String
    public var isCompleted: Bool

    public init(id: UUID = UUID(), task: String, isCompleted: Bool = false) {
        self.id = id
        self.task = task
        self.isCompleted = isCompleted
    }
}

public extension TodoEntity {
    func toTodo() -> Todo {
        Todo(id: id, task: task, isCompleted: isCompleted)
    }

    static func from(_ todo: Todo) -> TodoEntity {
        TodoEntity(id: todo.id, task: todo.task, isCompleted: todo.isCompleted)
    }
}
