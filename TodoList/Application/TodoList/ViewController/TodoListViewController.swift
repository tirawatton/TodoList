import UIKit

class TodoListViewController: UIViewController {

    static func instantiate() -> TodoListViewController {
        let storyboard = UIStoryboard(name: .main, bundle: .main)
        let viewController = storyboard.instantiate(TodoListViewController.self)
        return viewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }
}
