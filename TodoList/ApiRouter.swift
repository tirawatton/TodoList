import Alamofire

protocol ApiConfiguration: URLRequestConvertible {
    var method: HTTPMethod { get }
    var path: String { get }
    var body: [String: Any] { get }
    var headers: HTTPHeaders { get }
}

enum ApiRouter: ApiConfiguration {
    case loggedIn(email: String, password: String)
    case register(name: String, email: String, password: String, age: Int)
    case allTask(token: String)

    // MARK: - HTTPMethod
    internal var method: HTTPMethod {
        switch self {
        case .loggedIn:
            return .post
        case .register:
            return .post
        case .allTask:
            return .get
        }
    }

    // MARK: - Path
    internal var path: String {
        switch self {
        case .loggedIn:
            return "user/login"
        case .register:
            return "user/register"
        case .allTask:
            return "task"
        }
    }

    internal var body: [String : Any] {
        var bodyDict: [String: Any] = [:]

        switch self {
        case let .loggedIn(email: email, password: password):
            bodyDict[K.ApiBody.email] = email
            bodyDict[K.ApiBody.password] = password
        case let .register(name: name, email: email, password: password, age: age):
            bodyDict[K.ApiBody.name] = name
            bodyDict[K.ApiBody.email] = email
            bodyDict[K.ApiBody.password] = password
            bodyDict[K.ApiBody.age] = age
        default:
            break
        }

        return bodyDict
    }

    internal var headers: HTTPHeaders {
        var headers : HTTPHeaders = [:]

        switch self {
        case .loggedIn, .register:
            headers[HTTPHeaderField.contentType.rawValue] = ContentType.contentTypeValue.rawValue
        case let .allTask(token: token):
            headers[HTTPHeaderField.authentication.rawValue] = "Bearer \(token)"
        }

        return headers
    }

    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        let url = try K.Dev.baseURL.asURL()

        var urlRequest = URLRequest(url: url.appendingPathComponent(path))

        // HTTP Method
        urlRequest.httpMethod = method.rawValue
        urlRequest.allHTTPHeaderFields = headers.dictionary

        if let jsonData = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed) {
            if urlRequest.method != .get {
                urlRequest.httpBody = jsonData
            }
        }

        return urlRequest
    }
}
