import Foundation
import Alamofire

public struct Empty: Decodable {}

class ApiRequest {

    public static var shared = ApiRequest()

    func request<T: Decodable>(router: ApiRouter, completion: @escaping (Response<T, AppError>) -> Void) {
        AF.request(router)
            .responseData { response in

                let statusCode: Int = response.response?.statusCode ?? 0

                switch response.result {
                case .failure(let err):
                    let error = AppError.networkError(status: statusCode,
                                                      description: err.localizedDescription)
                    completion(.failure(error))
                case .success:

                    guard let data = response.data else {
                        completion(.failure(AppError.dataError(description: "Response is empty.")))
                        return
                    }

                    if let emptyResponse = Empty() as? T, data.count == 0 {
                        completion(.success(emptyResponse))
                        return
                    }

                    do {
                        guard let object = try? JSONDecoder().decode(T.self, from: data) else {
                            completion(.failure(.dataError(description: "Json Decode Error.")))
                            return
                        }
                        completion(.success(object))
                    }
                }
            }
    }

    func requestLoggedIn(email: String, password: String, completion: @escaping (Response<LoggedInModel, AppError>) -> Void) {
        request(router: .loggedIn(email: email, password: password), completion: completion)
    }

    func requestRegister(name: String ,email: String, password: String, age: Int, completion: @escaping (Response<LoggedInModel, AppError>) -> Void) {
        request(router: .register(name: name, email: email, password: password, age: age), completion: completion)
    }
}
