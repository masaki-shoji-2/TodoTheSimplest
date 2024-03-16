//
//  SettingsDataFlow.swift
//
//
//  Created by MasakiShoji on 2024/03/06.
//

import Combine
import Common
import Domain
import Foundation
import UICore

public struct SettingsDataFlow: DataFlow {
    public typealias UIState = State
    public typealias UIAction = Action
    public typealias UIStateProcessor = Processor

    @Observable
    public class State {
        let appConfig: AppConfig

        public init(appConfig: AppConfig) {
            self.appConfig = appConfig
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

public func mockSettingsStore() -> Store<SettingsDataFlow> {
    let state = SettingsDataFlow.State(
        appConfig: .init(
            buildConfig: .init(flavor: .prod, buldType: .release),
            description: "prod-release",
            versionName: "1.0.2"
        )
    )
    let processor = SettingsDataFlow.Processor()
    return Store<SettingsDataFlow>(state: state, processor: processor)
}
