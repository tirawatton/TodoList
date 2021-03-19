import Foundation

struct LogInModel: Decodable {
    var email: String = ""
    var password: String = ""
}

struct LoggedInModel: Decodable {
    var user: User
    var token: String
}

struct User: Decodable {
    var age: Int
    var id: String
    var name: String
    var email: String
    var createdAt: String
    var updatedAt: String
    var v: Int

    private enum CodingKeys: String, CodingKey {
        case age
        case id = "_id"
        case name, email, createdAt, updatedAt
        case v = "__v"
    }
}
