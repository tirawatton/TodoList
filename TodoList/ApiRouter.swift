import Alamofire

protocol ApiConfiguration: URLRequestConvertible {
    var method: HTTPMethod { get }
    var path: String { get }
    var body: [String: Any] { get }
    var headers: HTTPHeaders { get }
}

enum ApiRouter: ApiConfiguration {
    case loggedIn(email: String, password: String)

    // MARK: - HTTPMethod
    internal var method: HTTPMethod {
        switch self {
        case .loggedIn:
            return .post
        }
    }

    // MARK: - Path
    internal var path: String {
        switch self {
        case .loggedIn:
            return "user/login"
        }
    }

    internal var body: [String : Any] {
        var bodyDict: [String: Any] = [:]

        switch self {
        case let .loggedIn(email: email, password: password):
            bodyDict[K.ApiBody.email] = email
            bodyDict[K.ApiBody.password] = password
        }

        return bodyDict
    }

    internal var headers: HTTPHeaders {
        var headers : HTTPHeaders = [:]

        switch self {
        case .loggedIn:
            headers[HTTPHeaderField.contentType.rawValue] = ContentType.contentTypeValue.rawValue
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

        let jsonData = try JSONSerialization.data(withJSONObject: body)
        urlRequest.httpBody = jsonData

        return urlRequest
    }
}
