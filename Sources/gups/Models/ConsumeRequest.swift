//
//  ConsumeRequest.swift
//  gups
//
//  Created by Dan Mclean on 10/5/26.
//

import Vapor



struct ConsumeRequest: Content {
    let sessionid: String
    let sequence: String
    let cabinetid: String
    let cardid: String
    let value: Int
    let detail: String?
}


struct ConsumeResponse: Content {
    let status: Int
    let balance: Int
}
