//
//  File.swift
//  gups
//
//  Created by Dan Mclean on 10/5/26.
//

import Foundation
import Fluent
import Vapor

struct CabinetsController: RouteCollection {
    
    func boot(routes: any RoutesBuilder) throws {
        let todos = routes.grouped("cabinets")
        todos.get(use: self.index)
        todos.post(use: self.create)
        todos.group(":cabinetId") { todo in
            todo.delete(use: self.delete)
        }
    }

    @Sendable
    func index(req: Request) async throws -> [TransactionDTO] {
        try await Transaction.query(on: req.db).all().map { $0.toDTO() }
    }

    @Sendable
    func create(req: Request) async throws -> TransactionDTO {
        let todo = try req.content.decode(TransactionDTO.self).toModel()

        try await todo.save(on: req.db)
        return todo.toDTO()
    }

    @Sendable
    func delete(req: Request) async throws -> HTTPStatus {
        guard let todo = try await Transaction.find(req.parameters.get("transactionId"), on: req.db) else {
            throw Abort(.notFound)
        }

        try await todo.delete(on: req.db)
        return .noContent
    }
}
