//
//  Destination.swift
//
//
//  Created by MasakiShoji on 2024/02/25.
//
import Domain

public enum Destination {
    public enum Todo {
        case list
        case detail(_: Domain.Todo)
        case edit(_: Domain.Todo = Domain.Todo.empty())
    }

    case todo(Todo)
    case settings
}
