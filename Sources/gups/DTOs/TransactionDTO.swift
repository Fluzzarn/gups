import Fluent
import Vapor

struct TransactionDTO: Content {
    var id: UUID?
    var sessionid: String?
    var sequence: String?
    var cabinetid: String?
    var cardid: String
    var value: Int
    var detail: String?
    var timestamp: Date?
    func toModel() -> Transaction {
        let model = Transaction()
        
        model.id = self.id
        model.sessionid = self.sessionid
        model.sequence = self.sequence
        model.cabinetid = self.cabinetid
        model.cardid = self.cardid
        model.value = self.value
        model.detail = self.detail
        model.timestamp = self.timestamp
        return model
    }
}
