//
//  CreateUsers.swift
//  gups
//
//  Created by Dan Mclean on 10/5/26.
//

import Fluent

struct CreateUsers: AsyncMigration {
    func prepare(on database: any Database) async throws {
        try await database.schema("users")
            .id()
            .field("name", .string)
            .field("cards", .array(of: .string), .required)
            .field("balance", .int, .required)
            .field("isSuperUser", .bool, .required)
            .create()
    }

    func revert(on database: any Database) async throws {
        try await database.schema("users").delete()
    }
}
