import Foundation

final class TodoListViewModel {

    private let service: TodoListRepositoryProtocol

    init(service: TodoListRepositoryProtocol = TodoListRepository()) {
        self.service = service
    }

    var reloadTableViewClosure: (() -> ())?

    var errorMessage = Bindable<String>()
    var isLoading = Bindable<Bool>()

    private var task: TodoListModel = TodoListModel() {
        didSet {
            reloadTableViewClosure?()
        }
    }

    var numberOfItems: Int {
        return task.data?.count ?? 0
    }

    func fetchAllTask(set token: String) {
        isLoading.value = true
        service.fetchAllTask(token: token) { [weak self] task in
            self?.task = task
            self?.isLoading.value = false
        } error: { [weak self] error in
            self?.errorMessage.value = error.localizedDescription
            self?.isLoading.value = false
        }
    }

    func getUserTaskData(at indexPath: IndexPath) -> UserData {
        return task.data![indexPath.item]
    }
}
