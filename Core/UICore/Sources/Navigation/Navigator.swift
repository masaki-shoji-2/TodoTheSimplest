import SwiftUI

public protocol Navigator {
    func navigate(_ destination: Destination) -> AnyView
}

public class MockNavigator: Navigator {
    public init() {}

    public func navigate(_: Destination) -> AnyView {
        AnyView(EmptyView())
    }
}
