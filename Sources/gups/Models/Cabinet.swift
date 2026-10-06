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
final class Cabinet: Model,@unchecked Sendable {
    
    static let schema = "todos"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "cabinetid")
    var cabinetid: String
    
    @Field(key: "owners")
    var owners: [String]
    
    @Field(key: "cabinetid")
    var detail: String?

    init() { }
    
    func toDTO() -> CabinetDTO {
        .init(
            id: self.id,
            cabinetid: self.cabinetid,
            owners: self.owners,
            details: self.detail
        )
    }
}
