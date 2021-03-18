import UIKit

final class TodoListCoordinator: Coordinator {

    private(set) var childCoordinator: [Coordinator] = []
    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func startViewController() {
        let productsViewController = MainNavigationController()
        navigationController.setViewControllers([productsViewController], animated: false)
    }
}
