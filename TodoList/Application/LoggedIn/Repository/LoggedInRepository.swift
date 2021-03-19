import Foundation

protocol LoggedInRepositoryProtocol {
    func fetchLogged(email: String, password: String, completion: @escaping (LoggedInModel) -> Void, error: @escaping (AppError) -> Void)
}

final class LoggedInRepository: LoggedInRepositoryProtocol {
    func fetchLogged(email: String,
                     password: String,
                     completion: @escaping (LoggedInModel) -> Void,
                     error: @escaping (AppError) -> Void) {

        ApiRequest.shared.requestLoggedIn(email: email, password: password) { result in
            switch result {
            case .success(let loggedIn):
                completion(loggedIn)
            case .failure(let err):
                error(err)
            }
        }
    }
}
