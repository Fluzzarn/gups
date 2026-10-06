//
//  Foundation.swift
//  gups
//
//  Created by Dan Mclean on 10/5/26.
//


import Fluent
import struct Foundation.UUID

/// Property wrappers interact poorly with `Sendable` checking, causing a warning for the `@ID` property
/// It is recommended you write your model with sendability checking on and then suppress the warning
/// afterwards with `@unchecked Sendable`.
final class User: Model, @unchecked Sendable {
    
    
    
    
    init(id: UUID? = nil, name: String, cardIds: [String], balance: Int, isSuperUser: Bool = false) {
        self.id = id
        self.name = name
        self.cardIds = cardIds
        self.balance = balance
        self.isSuperUser = isSuperUser
        
    }
    
    static let schema = "users"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "name")
    var name: String
    
    @Field(key: "cardids")
    var cardIds: [String]
    
    @Field(key: "balance")
    var balance: Int
    
    @Field(key: "isSuperUser")
    var isSuperUser: Bool

    init() { }
    
    func toDTO() -> UserDTO {
        .init(
            id: self.id,
            balance: self.balance, cardids: self.cardIds,
            isSuperUser: self.isSuperUser
        )
    }
}
