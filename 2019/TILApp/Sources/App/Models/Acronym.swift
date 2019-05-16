//
//  Acronym.swift
//  App
//
//  Created by Peter Bødskov on 09/05/2019.
//

import FluentMySQL
import Vapor

final class Acronym: Codable {
    var id: Int?
    var short: String
    var long: String
    var userID: User.ID
    
    init(short: String, long: String, userID: User.ID) {
        self.short = short
        self.long = long
        self.userID = userID
    }
}

extension Acronym: MySQLModel { }
extension Acronym: Content { }
extension Acronym: Migration { }
extension Acronym: Parameter { }
extension Acronym {
    var user: Parent<Acronym, User> {
        return parent(\.userID)
    }
    
    var categories: Siblings<Acronym, Category, AcronymCategoryPivot> {
        return siblings()
    }
}
