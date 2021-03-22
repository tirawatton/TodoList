import Foundation

final class RegisterViewModel {
    private let service: RegisterRepositoryProtocol

    init(service: RegisterRepositoryProtocol = RegisterRepository()) {
        self.service = service
    }

    private var userRegister: RegisterModel = RegisterModel() {
        didSet {
            name = userRegister.name
            email = userRegister.email
            password = userRegister.password
            age = String(userRegister.age)
        }
    }
    
    private var name = ""
    private var email = ""
    private var password = ""
    private var age = ""

    var registerInputErrorMessage = Bindable<String>()
    var isNameTextFieldEmpty = Bindable<Bool>()
    var isAgeTextFieldEmpty = Bindable<Bool>()
    var isEmailTextFieldEmpty = Bindable<Bool>()
    var isPasswordTextFieldEmptry = Bindable<Bool>()
    var errorMessage = Bindable<String>()
    var isLoading = Bindable<Bool>()
    var isRegisterSuccessful = Bindable<Bool>()

    func updateRegister(name: String, email: String, password: String, age: Int) {
        isLoading.value = true

        userRegister.name = name
        userRegister.email = email
        userRegister.password = password
        userRegister.age = age
    }

    func toRegister() {
        isRegisterSuccessful.value = false

        service.fetchRegister(name: name, email: email, password: password, age: Int(age) ?? 1) { [weak self] success in
            self?.isLoading.value = false
            self?.isRegisterSuccessful.value = true
        } error: { [weak self] error in
            self?.isLoading.value = false
            self?.isRegisterSuccessful.value = false
            self?.registerInputErrorMessage.value = "Your registation is not completed."
        }
    }

    func registerInput() -> RegisterInputStatus {
        if email.isEmpty && password.isEmpty {
            return .incorrect
        }

        if email.isEmpty {
            registerInputErrorMessage.value = "Please enter your Email."
            isEmailTextFieldEmpty.value = true
            return .incorrect
        }

        if password.isEmpty {
            registerInputErrorMessage.value = "Please enter your Password."
            isPasswordTextFieldEmptry.value = true
            return .incorrect
        }

        if name.isEmpty {
            registerInputErrorMessage.value = "Please enter your name."
            isNameTextFieldEmpty.value = true
            return .incorrect
        }

        if age.isEmpty {
            registerInputErrorMessage.value = "Please enter your age."
            isAgeTextFieldEmpty.value = true
            return .incorrect
        }

        return .correct
    }
}


extension RegisterViewModel {
    enum RegisterInputStatus {
        case correct
        case incorrect
    }
}
