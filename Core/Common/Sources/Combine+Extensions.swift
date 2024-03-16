//
//  Combine+Extensions.swift
//
//
//  Created by MasakiShoji on 2024/03/06.
//

import Combine
import Foundation

public extension AnyPublisher {
    func toAnyCancellableOnMain<S>(
        on scheduler: S = DispatchQueue.main,
        options: S.SchedulerOptions? = nil,
        receiveCompletion: @escaping ((Subscribers.Completion<Self.Failure>) -> Void) = { _ in },
        receiveValue: @escaping ((Self.Output) async -> Void)
    ) -> AnyCancellable where S: Scheduler {
        receive(
            on: scheduler,
            options: options
        )
        .sink { completion in
            receiveCompletion(completion)
        } receiveValue: { output in
            Task { @MainActor in
                await receiveValue(output)
            }
        }
    }
}
