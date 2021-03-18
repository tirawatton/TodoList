import Foundation

extension UserDefaults {
    enum UserDefaultKeys: String {
        case isLoggedIn
    }

    func setIsLoggedIn(set value: Bool) {
        set(value, forKey: UserDefaultKeys.isLoggedIn.rawValue)
        synchronize()
    }

    func isLoggedIn() -> Bool {
        return bool(forKey: UserDefaultKeys.isLoggedIn.rawValue)
    }
}
