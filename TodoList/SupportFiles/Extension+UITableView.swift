import UIKit

extension UITableViewCell {
    // The @objc is added to silence the complier errors
    @objc class var reuseIdentifier: String {
        return String(describing: self)
    }

    @objc class var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: .main)
    }
}
