//
//  CabinetsController.swift
//  gups
//
//  Created by Dan Mclean on 10/5/26.
//


//
//  File.swift
//  gups
//
//  Created by Dan Mclean on 10/5/26.
//

import Foundation
import Fluent
import Vapor

struct UsersController: RouteCollection {
    
    func boot(routes: any RoutesBuilder) throws {
        let todos = routes.grouped("users")
        todos.get(use: self.index)
        todos.post(use: self.create)
        todos.group(":userId") { todo in
            todo.delete(use: self.delete)
        }
    }

    @Sendable
    func index(req: Request) async throws -> [UserDTO] {
        try await User.query(on: req.db).all().map { $0.toDTO() }
    }
    
    @Sendable
    func create(req: Request) async throws -> UserDTO {
        let todo = try req.content.decode(UserDTO.self).toModel()

        try await todo.save(on: req.db)
        return todo.toDTO()
    }

    @Sendable
    func delete(req: Request) async throws -> HTTPStatus {
        guard let todo = try await Transaction.find(req.parameters.get("userId"), on: req.db) else {
            throw Abort(.notFound)
        }

        try await todo.delete(on: req.db)
        return .noContent
    }
}
