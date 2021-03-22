import Foundation

protocol TodoListRepositoryProtocol {
    func fetchAllTask(token: String, completion: @escaping (TodoListModel) -> Void, error: @escaping (AppError) -> Void)
}

final class TodoListRepository: TodoListRepositoryProtocol {
    func fetchAllTask(token: String, completion: @escaping (TodoListModel) -> Void, error: @escaping (AppError) -> Void) {
        ApiRequest.shared.requestAllTask(token: token) { result in
            switch result {
            case .success(let task):
                completion(task)
            case .failure(let err):
                error(err)
            }
        }
    }
}
