//
//  File.swift
//  gups
//
//  Created by Dan Mclean on 10/5/26.
//

import Foundation
import Vapor

struct SecretMiddleware: AsyncMiddleware {
    func respond(to request: Request, chainingTo next: any AsyncResponder) async throws -> Response {
        request.logger.info("HIT SECRET ENDPOINT")
        guard let key = request.headers.first(name: "X-remoteeacoin-psk"), key == Environment.get("GUPS_SHARED_KEY") else {
            throw Abort(.unauthorized)
        }
        return try await next.respond(to: request)
    }
}
