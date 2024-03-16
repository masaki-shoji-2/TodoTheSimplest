//
//  BuildConfig.swift
//
//
//  Created by MasakiShoji on 2024/03/15.
//

public struct BuildConfig {
    let flavor: Flavor
    let buldType: BuildType

    public init(flavor: Flavor, buldType: BuildType) {
        self.flavor = flavor
        self.buldType = buldType
    }
}

public enum Flavor: String {
    case dev
    case stg
    case prod
}

public enum BuildType: String {
    case debug
    case release
}
