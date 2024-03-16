import Combine
import Foundation

public protocol TodoRepository {
    func fetchAll() async -> AnyPublisher<[Todo], Error>
    func insert(_ todo: Todo) async -> AnyPublisher<Void, Error>
    func delete(id: UUID) async -> AnyPublisher<UUID, Error>
}

public class MockTodoRepository: TodoRepository {
    public init() {}
    public func fetchAll() async -> AnyPublisher<[Todo], Error> {
        Future<[Todo], Error> { promise in
            let todos = [
                Todo(id: UUID(), task: "task1", isCompleted: false),
                Todo(id: UUID(), task: "task2", isCompleted: false),
            ]
            promise(.success(todos))
        }.eraseToAnyPublisher()
    }

    public func insert(_: Todo) async -> AnyPublisher<Void, Error> {
        Future<Void, Error> { promise in
            promise(.success(()))
        }.eraseToAnyPublisher()
    }

    public func delete(id _: UUID) async -> AnyPublisher<UUID, Error> {
        Future<UUID, Error> { promise in
            promise(.success(UUID()))
        }.eraseToAnyPublisher()
    }
}
