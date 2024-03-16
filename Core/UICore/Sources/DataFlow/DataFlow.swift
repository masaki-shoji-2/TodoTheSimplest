//
//  DataFlow.swift
//
//
//  Created by MasakiShoji on 2024/02/25.
//

public typealias Dispatch<T> = (T) -> Void

public protocol StateProcessor<UIState, UIAction> {
    associatedtype UIState: AnyObject
    associatedtype UIAction
    func process(state: UIState, action: UIAction, dispatch: @escaping Dispatch<UIAction>) async
}

public protocol DataFlow {
    associatedtype UIState: AnyObject
    associatedtype UIAction
    associatedtype UIStateProcessor: StateProcessor<UIState, UIAction>
}
