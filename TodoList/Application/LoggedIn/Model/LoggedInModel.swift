import Foundation

struct LogInModel: Codable {
    var email: String = ""
    var password: String = ""
}

struct LoggedInModel: Codable {
    var user: User
    var token: String

    func saveUserData() {
        if let encoded = try? PropertyListEncoder().encode(self) {
            UserDefaults.standard.setUserSession(set: encoded)
        }
    }

    static var currentUser: LoggedInModel? {
        let userData = UserDefaults.standard.userSession()
        if let user = try? PropertyListDecoder().decode(LoggedInModel.self, from: userData) {
            return user
        }

        return nil
    }
}

struct User: Codable {
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
