import UIKit

final class MainNavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if isLoggedIn() {
            let viewController = TodoListViewController.instantiate()
            viewControllers = [viewController]
        } else {
            perform(#selector(showIntrodctionPage), with: nil, afterDelay: 0.01)
        }
    }

    private func isLoggedIn() -> Bool {
//        return UserDefaults.standard.isLoggedIn()
        return false
    }

    @objc func showIntrodctionPage() {
        let viewController = LoggedInViewController.instantiate(for: LoggedInViewModel())
        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: true, completion: nil)
    }
}
