import UIKit

final class MainNavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if isLoggedIn() {
            let viewController = TodoListViewController.instantiate(for: TodoListViewModel())
            viewControllers = [viewController]
        } else {
            perform(#selector(showLoginScreen), with: nil, afterDelay: 0.01)
        }
    }

    private func isLoggedIn() -> Bool {
        return UserDefaults.standard.isLoggedIn()
    }

    @objc func showLoginScreen() {
        let viewController = LoggedInViewController.instantiate(for: LoggedInViewModel())
        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: true, completion: nil)
    }
}
