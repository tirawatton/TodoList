import UIKit

class LoggedInViewController: UIViewController {

    static func instantiate() -> LoggedInViewController {
        let storyboard = UIStoryboard(name: .main, bundle: .main)
        let viewController = storyboard.instantiate(LoggedInViewController.self)
        return viewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }
}
