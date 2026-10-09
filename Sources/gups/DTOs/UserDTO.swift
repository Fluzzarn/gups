//
//  UserDTO.swift
//  gups
//
//  Created by Dan Mclean on 10/5/26.
//

import Fluent
import Vapor

struct UserDTO: Content {
    var id: UUID?
    var balance: Int
    var cardids: [String]
    var isSuperUser: Bool
    var name:String
    func toModel() -> User {
        let model = User()
        
        model.id = self.id
        model.balance = self.balance
        model.cardIds = self.cardids
        model.isSuperUser = self.isSuperUser
        model.name = self.name
        return model
    }
}
