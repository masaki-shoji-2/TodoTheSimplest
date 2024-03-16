//
//  SettingsAssembly.swift
//
//
//  Created by MasakiShoji on 2024/02/25.
//

import Common
import Domain
import Swinject
import UICore

public final class SettingsAssembly: Assembly {
    public func assemble(container: Container) {
        container.register(SettingsDataFlow.State.self) { r in
            let appConfig = r.resolve(AppConfig.self)!
            return .init(appConfig: appConfig)
        }

        container.register(SettingsDataFlow.Processor.self) { _ in
            .init()
        }

        container.register(Store<SettingsDataFlow>.self, name: "settingsStore") { r in
            let state = r.resolve(SettingsDataFlow.State.self)!
            let processor = r.resolve(SettingsDataFlow.Processor.self)!
            return .init(state: state, processor: processor)
        }

        container.register(SettingsView.self) { r in
            let store = r.resolve(Store<SettingsDataFlow>.self, name: "settingsStore")!
            return SettingsView(store: store)
        }
    }
}
