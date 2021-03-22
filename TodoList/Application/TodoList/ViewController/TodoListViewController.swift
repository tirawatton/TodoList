import UIKit

class TodoListViewController: UIViewController {

    lazy var viewModel: TodoListViewModel = {
        return TodoListViewModel()
    }()

    var tableViewAdapter: TodoListTableViewAdapter!

    static func instantiate(for viewModel: TodoListViewModel) -> TodoListViewController {
        let storyboard = UIStoryboard(name: .main, bundle: .main)
        let viewController = storyboard.instantiate(TodoListViewController.self)
        viewController.viewModel = viewModel
        return viewController
    }

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        initViewModel()
        setupTableView()

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logout))
    }

    @objc private func logout() {
        let viewController = LoggedInViewController.instantiate(for: LoggedInViewModel())
        viewController.modalPresentationStyle = .fullScreen

        UserDefaults.standard.setIsLoggedIn(set: false)
        UserDefaults.standard.logout()

        present(viewController, animated: true)
    }

    private func initViewModel() {
        viewModel.reloadTableViewClosure = { [weak self] in
            DispatchQueue.main.async {
                guard let strongSelf = self else { return }
                strongSelf.tableView.reloadData()
            }
        }

        viewModel.isLoading.bind { isLoading in
            DispatchQueue.main.async {
                guard let isLoading = isLoading else { return }
                if isLoading {
                    UIView.animate(withDuration: 0.1) {
                        self.tableView.alpha = 0
                        ProgessHUD.shared.showHud()
                    }
                } else {
                    UIView.animate(withDuration: 0.1) {
                        self.tableView.alpha = 1
                        ProgessHUD.shared.hideHud()
                    }
                }
            }
        }

        guard let token = LoggedInModel.currentUser?.token else { return }
        viewModel.fetchAllTask(set: token)
    }

    private func setupTableView() {
        tableViewAdapter = TodoListTableViewAdapter(delegate: self)
        tableView.delegate = tableViewAdapter
        tableView.dataSource = tableViewAdapter

        tableView.register(TodoListTableViewCell.nib, forCellReuseIdentifier: TodoListTableViewCell.reuseIdentifier)
    }
}

extension TodoListViewController: TodoListTableViewAdapterProtocol {
    func getAllTaskUser(at indexPath: IndexPath) -> UserData {
        return viewModel.getUserTaskData(at: indexPath)
    }

    func retrieveNumberOfItems() -> Int {
        return viewModel.numberOfItems
    }
}
