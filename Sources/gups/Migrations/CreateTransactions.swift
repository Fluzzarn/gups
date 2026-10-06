import Fluent

struct CreateTransactions: AsyncMigration {
    func prepare(on database: any Database) async throws {
        try await database.schema("transactions")
            .id()
            .field("timestamp", .date, .required)
            .field("sessionid", .string)
            .field("sequence", .string)
            .field("cabinetid", .string)
            .field("cardid", .string, .required)
            .field("value", .int, .required)
            .field("detail", .string)
            .create()
    }

    func revert(on database: any Database) async throws {
        try await database.schema("transactions").delete()
    }
}
