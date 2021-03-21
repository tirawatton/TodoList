import Foundation

struct RegisterModel: Decodable {
    var name: String = ""
    var email: String = ""
    var password: String = ""
    var age: Int = 1
}
