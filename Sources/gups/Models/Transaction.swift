import Foundation
import Fluent
import struct Foundation.UUID

/// Property wrappers interact poorly with `Sendable` checking, causing a warning for the `@ID` property
/// It is recommended you write your model with sendability checking on and then suppress the warning
/// afterwards with `@unchecked Sendable`.
final class Transaction: Model, @unchecked Sendable {
    
    
    init(id: UUID? = nil, sessionid: String, sequence: String, cabinetid: String? = nil, cardid: String, value: Int, detail: String? = nil) {
        self.id = id
        self.sessionid = sessionid
        self.sequence = sequence
        self.cabinetid = cabinetid
        self.cardid = cardid
        self.value = value
        self.detail = detail
    }
    
    static let schema = "transactions"
    
    @ID(key: .id)
    var id: UUID?

    @Field(key: "sessionid")
    var sessionid: String?
    
    @Field(key: "sequence")
    var sequence: String?
    
    @Field(key: "cabinetid")
    var cabinetid: String?
    
    @Field(key: "cardid")
    var cardid: String
    
    @Field(key: "cabinetid")
    var value: Int
    
    @Field(key: "cabinetid")
    var detail: String?
    
    @Timestamp(key: "timestamp", on: .create)
    var timestamp: Date?

    init() { }
    
    func toDTO() -> TransactionDTO {
        .init(
            id: self.id,
            sessionid: self.sessionid,
            sequence: self.sequence,
            cabinetid: self.cabinetid,
            cardid: self.cardid,
            value: self.value,
            detail: self.detail,
            timestamp: self.timestamp
        )
    }
}
