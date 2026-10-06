//
//  File.swift
//  gups
//
//  Created by Dan Mclean on 10/5/26.
//

import Foundation
import Vapor

struct GetRequestModel: Content {
    var cabinetid: String
    var cardid: String
}


struct GetResponsetModel: Content {
    var status: Int
    var balance: String
}
