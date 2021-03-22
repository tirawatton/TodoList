import UIKit

protocol TodoListTableViewAdapterProtocol: class {
    func getAllTaskUser(at indexPath: IndexPath) -> UserData
    func retrieveNumberOfItems() -> Int
}

class TodoListTableViewAdapter: NSObject {

    weak var delegate: TodoListTableViewAdapterProtocol?


    init(delegate: TodoListTableViewAdapterProtocol) {
        self.delegate = delegate
    }
}

extension TodoListTableViewAdapter: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
}

extension TodoListTableViewAdapter: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return delegate?.retrieveNumberOfItems() ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TodoListTableViewCell.reuseIdentifier, for: indexPath) as! TodoListTableViewCell
        let data = delegate?.getAllTaskUser(at: indexPath)
        cell.taskData = data
        return cell
    }
}
