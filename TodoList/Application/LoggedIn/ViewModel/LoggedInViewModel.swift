import Foundation

final class LoggedInViewModel {

    private let service: LoggedInRepositoryProtocol

    init(service: LoggedInRepositoryProtocol = LoggedInRepository()) {
        self.service = service
    }

    var updateLoadingStatusClosure: (() -> ())?

    private var userLogIn: LogInModel = LogInModel() {
        didSet {
            email = userLogIn.email
            password = userLogIn.password
        }
    }

    private var email = ""
    private var password = ""

    var loggedInInputErrorMessage = Bindable<String>()
    var isEmailTextFieldEmpty = Bindable<Bool>()
    var isPasswordTextFieldEmptry = Bindable<Bool>()
    var errorMessage = Bindable<String>()
    var isLoading = Bindable<Bool>()
    var isLoggedInSuccessful = Bindable<Bool>()

    var userDetail = Bindable<LoggedInModel>()

    func updateLoggedIn(email: String, password: String) {
        isLoading.value = true

        userLogIn.email = email
        userLogIn.password = password
    }

    func toLogIn() {
        isLoggedInSuccessful.value = false
        service.fetchLogged(email: email, password: password) { [weak self] loggedIn in
            self?.userDetail.value = loggedIn
            self?.isLoading.value = false
            self?.isLoggedInSuccessful.value = true

            self?.userDetail.value?.saveUserData()
        } error: { [weak self] error in
            self?.errorMessage.value = "Your email or password is incorrect."
            self?.isLoading.value = false
            self?.isLoggedInSuccessful.value = false
        }
    }

    func logInInput() -> LoggedInInputStatus {
        if email.isEmpty && password.isEmpty {
            return .incorrect
        }
        if email.isEmpty {
            loggedInInputErrorMessage.value = "Please enter your Email."
            isEmailTextFieldEmpty.value = true
            return .incorrect
        }
        if password.isEmpty {
            loggedInInputErrorMessage.value = "Please enter your Password."
            isPasswordTextFieldEmptry.value = true
            return .incorrect
        }
        
        return .correct
    }
}

extension LoggedInViewModel {
    enum LoggedInInputStatus {
        case correct
        case incorrect
    }
}
