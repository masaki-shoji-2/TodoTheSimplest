import Combine
import Common
import Domain
import SwiftData
import SwiftUI

public protocol DataSource {
    func insert<T: Entity>(_ entity: T) async -> AnyPublisher<Void, Error>
    func fetchAll<T: Entity>(_ entityType: T.Type) async -> AnyPublisher<[T], Error>
    func deleteById<T: Entity>(_ entityType: T.Type, id: UUID) async -> AnyPublisher<UUID, Error>
}

public actor DataSourceImpl: DataSource, ModelActor {
    public let modelContainer: ModelContainer
    public let modelExecutor: ModelExecutor
    private let context: ModelContext

    public init(container: ModelContainer) {
        modelContainer = container
        context = ModelContext(container)
        modelExecutor = DefaultSerialModelExecutor(modelContext: context)
    }

    public func insert(_ entity: some Entity) async -> AnyPublisher<Void, Error> {
        Future<Void, Error> { promise in
            do {
                self.context.insert(entity)
                try self.context.save()
                promise(.success(()))
            } catch {
                promise(.failure(DatabaseError.crudError(error)))
            }
        }
        .eraseToAnyPublisher()
    }

    public func fetchAll<T>(_: T.Type) async -> AnyPublisher<[T], Error>
        where T: Entity
    {
        return Future<[T], Error> { promise in
            do {
                return try promise(.success(self.context.fetch(FetchDescriptor<T>())))
            } catch {
                return promise(.failure(DatabaseError.crudError(error)))
            }
        }
        .eraseToAnyPublisher()
    }

    public func deleteById(_: (some Entity).Type, id: UUID) -> AnyPublisher<UUID, Error> {
        Future<UUID, Error> { promise in
            do {
                try self.context.delete(
                    model: TodoEntity.self,
                    where: #Predicate { entity in
                        entity.id == id
                    }
                )
                try self.context.save()
                promise(.success(id))
            } catch {
                promise(.failure(DatabaseError.crudError(error)))
            }
        }
        .eraseToAnyPublisher()
    }
}
