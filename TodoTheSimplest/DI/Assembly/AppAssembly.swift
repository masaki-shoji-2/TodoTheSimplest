//
//  AppAssembly.swift
//
//
//  Created by MasakiShoji on 2024/02/25.
//

import Common
import Database
import Foundation
import Home
import Settings
import SwiftData
import Swinject
import Todo
import UICore

public final class AppAssembly: Assembly {
    @MainActor
    public func assemble(container: Container) {
        container.register(Navigator.self) { _ in
            AppNavigator()
        }
        .inObjectScope(.container)

        container.register(ModelContainer.self) { _ in
            do {
                return try ModelContainer(for: TodoEntity.self)
            } catch {
                fatalError()
            }
        }
        .inObjectScope(.container)

        container.register(ModelContext.self) { r in
            let modelContainer = r.resolve(ModelContainer.self)
            return modelContainer!.mainContext
        }
        .inObjectScope(.container)

        container.register(Flavor.self) { _ in
            #if DEBUG
                Flavor.dev
            #elseif ADHOC
                Flavor.stg
            #else
                Flavor.prod
            #endif
        }
        .inObjectScope(.container)

        container.register(BuildType.self) { _ in
            #if DEBUG
                BuildType.debug
            #else
                BuildType.release
            #endif
        }
        .inObjectScope(.container)

        container.register(BuildConfig.self) { r in
            let buildType = r.resolve(BuildType.self)!
            let flavor = r.resolve(Flavor.self)!
            return .init(flavor: flavor, buldType: buildType)
        }
        .inObjectScope(.container)

        container.register(String.self, name: "appDescription") { r in
            let buildType = r.resolve(BuildType.self)!
            let flavor = r.resolve(Flavor.self)!
            return "\(flavor.rawValue)-\(buildType.rawValue)"
        }
        .inObjectScope(.container)

        container.register(AppConfig.self) { r in
            let buildConfig = r.resolve(BuildConfig.self)!
            let description = r.resolve(String.self, name: "appDescription")!
            let versionName = Bundle.main.object(
                forInfoDictionaryKey: "CFBundleShortVersionString"
            ) as! String

            return .init(
                buildConfig: buildConfig,
                description: description,
                versionName: versionName
            )
        }
        .inObjectScope(.container)
    }
}
