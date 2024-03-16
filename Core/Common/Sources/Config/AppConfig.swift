//
//  AppConfig.swift
//
//
//  Created by MasakiShoji on 2024/03/15.
//

public struct AppConfig {
    public let buildConfig: BuildConfig
    public let description: String
    public let versionName: String

    public init(
        buildConfig: BuildConfig,
        description: String,
        versionName: String
    ) {
        self.buildConfig = buildConfig
        self.description = description
        self.versionName = versionName
    }
}
