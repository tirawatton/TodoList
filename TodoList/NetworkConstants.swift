import Foundation

internal struct K {
    struct Dev {
        static let baseURL = "https://api-nodejs-todolist.herokuapp.com"
    }

    struct ApiBody {
        static let email = "email"
        static let password = "password"
    }
}

internal enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
}

internal enum ContentType: String {
    case contentTypeValue = "application/json"
}
