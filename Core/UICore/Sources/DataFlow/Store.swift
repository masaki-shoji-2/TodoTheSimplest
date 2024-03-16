import SwiftUI

@dynamicMemberLookup
public final class Store<T: DataFlow> {
    private var state: T.UIState
    private let processor: T.UIStateProcessor
    private lazy var dispatch: Dispatch<T.UIAction> = { action in
        Task { @MainActor in
            await self.processor.process(state: self.state, action: action, dispatch: self.dispatch)
        }
    }

    public init(
        state: T.UIState,
        processor: T.UIStateProcessor
    ) {
        self.state = state
        self.processor = processor
    }

    public subscript<A>(dynamicMember keyPath: KeyPath<T.UIState, A>) -> A {
        self.state[keyPath: keyPath]
    }

    public func binding<A>(
        referTo f: @escaping (_ state: T.UIState) -> A,
        onChange action: @escaping (_ value: A) -> Void
    ) -> Binding<A> {
        .init(
            get: { f(self.state) },
            set: { action($0) }
        )
    }

    public func dispatch(_ action: T.UIAction) {
        Task { @MainActor in
            await processor.process(state: state, action: action, dispatch: dispatch)
        }
    }
}
