import UIKit

protocol LoggedInViewControllerAdapterProtocol: class {
}

class LoggedInViewControllerAdapter: NSObject {

    weak var delegate: LoggedInViewControllerAdapterProtocol?

    init(delegate: LoggedInViewControllerAdapterProtocol) {
        self.delegate = delegate
    }
}
