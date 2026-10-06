//
//  CabinetDTO.swift
//  gups
//
//  Created by Dan Mclean on 10/5/26.
//

import Fluent
import Vapor

struct CabinetDTO: Content {
    var id: UUID?
    var cabinetid: String
    var owners: [String]
    var details: String?
    func toModel() -> Cabinet {
        let model = Cabinet()
        
        model.id = self.id
        model.owners = owners
        model.detail = self.details
        model.cabinetid = self.cabinetid
        return model
    }
}
