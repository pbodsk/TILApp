import FluentMySQL
import Vapor

final class Acronym: Codable {
    var id: Int?
    var short: String
    var long: String
    var creatorID: User.ID
    
    init(short: String, long: String, creatorID: User.ID) {
        self.short = short
        self.long = long
        self.creatorID = creatorID
    }
}

//This is what is needed normally
//extension Acronym: Model {
//    typealias Database = SQLiteDatabase //which database are we using?
//    typealias ID = Int //what type is ID
//    static let idKey: IDKey = \Acronym.id //what does id refer to, note \Acronym.id = keypath
//}

//however, since there already exists a SQLiteModel, we can use this marker protocol instead
extension Acronym: MySQLModel {}

//implement this marker protocol to support encode/decode
extension Acronym: Content {}

//implement this to support migrations
extension Acronym: Migration {}

//implement this to allow our model to be used as a paramter in URLs (when getting a single Acronym)
extension Acronym: Parameter {}

extension Acronym {
    var creator: Parent<Acronym, User> {
        return parent(\.creatorID)
    }
    
    var categories: Siblings<Acronym, Category, AcronymCategoryPivot> {
        return siblings()
    }
}
