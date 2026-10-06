//
//  CreateCabinets.swift
//  gups
//
//  Created by Dan Mclean on 10/5/26.
//

import Fluent

struct CreateCabinets: AsyncMigration {
    func prepare(on database: any Database) async throws {
        try await database.schema("cabinets")
            .id()
            .field("cabinetid", .string, .required)
            .field("owners", .array(of: .string), .required)
            .field("balance", .int, .required)
            .create()
    }

    func revert(on database: any Database) async throws {
        try await database.schema("users").delete()
    }
}
