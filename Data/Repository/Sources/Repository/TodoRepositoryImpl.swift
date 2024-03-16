import Combine
import Database
import Domain
import Foundation

public struct TodoRepositoryImpl: TodoRepository {
    private let dataSource: DataSource

    public init(dataSource: DataSource) {
        self.dataSource = dataSource
    }

    public func fetchAll() async -> AnyPublisher<[Todo], Error> {
        await dataSource.fetchAll(TodoEntity.self)
            .map { $0.map { todoEntity in todoEntity.toTodo() } }
            .eraseToAnyPublisher()
    }

    public func insert(_ todo: Todo) async -> AnyPublisher<Void, Error> {
        await dataSource.insert(TodoEntity.from(todo))
            .eraseToAnyPublisher()
    }

    public func delete(id: UUID) async -> AnyPublisher<UUID, Error> {
        await dataSource.deleteById(TodoEntity.self, id: id)
            .eraseToAnyPublisher()
    }
}
