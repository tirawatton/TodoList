import Foundation

extension UserDefaults {
    enum UserDefaultKeys: String {
        case isLoggedIn
        case userSession
    }

    func setIsLoggedIn(set value: Bool) {
        set(value, forKey: UserDefaultKeys.isLoggedIn.rawValue)
        synchronize()
    }

    func isLoggedIn() -> Bool {
        return bool(forKey: UserDefaultKeys.isLoggedIn.rawValue)
    }

    func setUserSession(set model: Data) {
        set(model, forKey: UserDefaultKeys.userSession.rawValue)
        synchronize()
    }

    func userSession() -> Data {
        guard let user = value(forKey: UserDefaultKeys.userSession.rawValue) as? Data else {
            return Data()
        }

        return user
    }

    func logout() {
        removeObject(forKey: UserDefaultKeys.userSession.rawValue)
    }
}
