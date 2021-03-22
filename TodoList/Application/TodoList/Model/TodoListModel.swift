import Foundation

struct TodoListModel: Decodable {
    var count: Int?
    var data: [UserData]?
}

struct UserData: Decodable {
    var completed: Bool
    var id: String
    var description: String
    var owner: String
    var createdAt: String
    var updatedAt: String
    var v: Int

    private enum CodingKeys: String, CodingKey {
        case completed, description, owner, createdAt, updatedAt
        case id = "_id"
        case v = "__v"
    }
}
