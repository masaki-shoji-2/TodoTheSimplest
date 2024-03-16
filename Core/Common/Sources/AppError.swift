//
//  AppError.swift
//
//
//  Created by MasakiShoji on 2024/03/05.
//

public enum AppError: Error {
    case apiError(ApiError)
    case databaseError(DatabaseError)
}

public enum ApiError: Error {
    case apiClosed
    case sessionExpired
    case networkTimeout
}

public enum DatabaseError: Error {
    case crudError(_ e: Error)
}
