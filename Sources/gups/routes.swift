import Fluent
import Vapor

func routes(_ app: Application) throws {
    
    let group = app.grouped(SecretMiddleware())
    group.post("get") { req in
        let request = try req.content.decode(GetRequestModel.self)
        let user = try await User.query(on: req.db).all().first(where: {$0.cardIds?.contains(request.cardid) ?? false})
        
        
        if let user = user {
            if user.isSuperUser ?? false {
                return GetResponsetModel(status: 0, balance: "9999")
            }
            
            let cabinet = try await Cabinet.query(on: req.db).filter(\.$cabinetid == request.cabinetid).first()
            if let cabinet = cabinet, cabinet.owners.contains(request.cardid)  {
                return GetResponsetModel(status: 0, balance: "9999")
            } else {
                return GetResponsetModel(status: 0, balance: "\(user.balance)")
            }
        } else {
            let newUser = User(name: "UNKNOWN", cardIds: [request.cardid], balance: 0)
            try await newUser.save(on: req.db)
            return GetResponsetModel(status: 0, balance: "0")
        }
    }
    
    group.post("consume") { req in
        let request = try req.content.decode(ConsumeRequest.self)
        let user = try await User.query(on: req.db).all().first(where: {$0.cardIds?.contains(request.cardid) ?? false})
        let transaction = Transaction(sessionid: request.sessionid, sequence: request.sequence, cardid: request.cardid, value: request.value, detail: request.detail)
        try await transaction.save(on: req.db)
        if let user = user {
            if user.isSuperUser ?? false {
                return ConsumeResponse(status: 0, balance: 9999)
            }
            
            let cabinet = try await Cabinet.query(on: req.db).filter(\.$cabinetid == request.cabinetid).first()
            if let cabinet = cabinet, cabinet.owners.contains(request.cardid)  {
                return ConsumeResponse(status: 0, balance: 9999)
            } else {
                if( user.balance - request.value < 0) {
                    user.balance -= request.value
                    try await user.save(on: req.db)
                    return ConsumeResponse(status: 0, balance: user.balance)
                } else {
                    return ConsumeResponse(status: 1, balance: user.balance)
                }
            }
        } else {
            return ConsumeResponse(status: 1, balance: 0)
        }
    }
    
    
    
    
    app.get { req async throws in
        try await req.view.render("index", ["title": "Hello Vapor!"])
    }

    try app.register(collection: TransactionsController())
    try app.register(collection: CabinetsController())
    try app.register(collection: UsersController())
}
