import Foundation
import Observation

@Observable
public class Todo: Identifiable, Equatable {
    public let id: UUID
    public var task: String
    public var isCompleted: Bool

    public init(id: UUID = UUID(), task: String, isCompleted: Bool) {
        self.id = id
        self.task = task
        self.isCompleted = isCompleted
    }

    public static func == (lhs: Todo, rhs: Todo) -> Bool {
        lhs.id == rhs.id
    }
}

public extension Todo {
    static func empty() -> Todo {
        Todo(task: "", isCompleted: false)
    }
}
