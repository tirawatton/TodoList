import Foundation

protocol RegisterRepositoryProtocol {
    func fetchRegister(name: String, email: String, password: String, age: Int, completion: @escaping (LoggedInModel) -> Void, error: @escaping (AppError) -> Void)
}

class RegisterRepository: RegisterRepositoryProtocol {
    func fetchRegister(name: String, email: String, password: String, age: Int, completion: @escaping (LoggedInModel) -> Void, error: @escaping (AppError) -> Void) {
        ApiRequest.shared.requestRegister(name: name, email: email, password: password, age: age) { result in
            switch result {
            case .success(let register):
                completion(register)
            case .failure(let err):
                error(err)
            }
        }
    }
}
