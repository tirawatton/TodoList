import Foundation
import MBProgressHUD

class ProgessHUD {

    private var HUD = MBProgressHUD()
    static let shared = ProgessHUD()

    func showHud() {
        let view = UIApplication.shared.windows.filter { $0.isKeyWindow }.first
        HUD = MBProgressHUD.showAdded(to: view!, animated: true)
        HUD.backgroundColor = UIColor(white: 0, alpha: 0.5)
    }

    func hideHud() {
        HUD.hide(animated: true)
    }
}
