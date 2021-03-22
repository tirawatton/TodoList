import UIKit
import SkyFloatingLabelTextField

class LoggedInViewController: UIViewController {

    lazy var viewModel: LoggedInViewModel = {
        return LoggedInViewModel()
    }()

    static func instantiate(for viewModel: LoggedInViewModel) -> LoggedInViewController {
        let storyboard = UIStoryboard(name: .main, bundle: .main)
        let viewController = storyboard.instantiate(LoggedInViewController.self)
        viewController.viewModel = viewModel
        return viewController
    }

    @IBOutlet weak var emailTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var passwordTextField: SkyFloatingLabelTextField!

    @IBOutlet weak var shadowBackgroundView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        setupUI()
        setupTextFieldState()

        emailTextField.text = "muh.nurali43@gmail.com"
        passwordTextField.text = "12345678"
    }

    private func setupUI() {
        passwordTextField.enablePasswordToggle()

        emailTextField.delegate = self
        passwordTextField.delegate = self
    }

    private func setupTextFieldState() {
        viewModel.loggedInInputErrorMessage.bind { [weak self] isEmpty in
            self?.emailTextField.errorMessage = "Please enter your Email."
            self?.passwordTextField.errorMessage = "Please enter your Email."
        }

        viewModel.isEmailTextFieldEmpty.bind { [weak self] isEmpty in
            DispatchQueue.main.async {
                guard let isEmpty = isEmpty else { return }
                if isEmpty {
                    self?.emailTextField.selectedLineColor = .red
                }
            }
        }

        viewModel.isPasswordTextFieldEmptry.bind { [weak self] isEmpty in
            DispatchQueue.main.async {
                guard let isEmpty = isEmpty else { return }
                if isEmpty {
                    self?.passwordTextField.selectedLineColor = .red
                }
            }
        }

        viewModel.errorMessage.bind {
            guard let errorMessage = $0 else { return }
            self.displayAlert(message: errorMessage)
        }
    }

    private func bindViewModel() {
        viewModel.isLoading.bind { isLoading in
            DispatchQueue.main.async {
                guard let isLoading = isLoading else { return }
                if isLoading {
                    ProgessHUD.shared.showHud()
                } else {
                    ProgessHUD.shared.hideHud()
                }
            }
        }

        viewModel.isLoggedInSuccessful.bind { [weak self] isSuccessful in
            DispatchQueue.main.async {
                guard let isSuccessful = isSuccessful else { return }
                if isSuccessful {
                    self?.isLoggedInSuccessfull()
                }
            }
        }
    }

    private func displayAlert(message: String) {
        let dialogMessage = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)

        let ok = UIAlertAction(title: "Retry", style: .default, handler: { (action) -> Void in
        })

        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) -> Void in
        }

        dialogMessage.addAction(ok)
        dialogMessage.addAction(cancel)

        self.present(dialogMessage, animated: true, completion: nil)
    }

    private func isLoggedInSuccessfull() {
        let rootViewController = UIApplication.shared.windows.filter { $0.isKeyWindow }.first?.rootViewController
        guard let mainViewController = rootViewController as? MainNavigationViewController else { return }

        let viewController = TodoListViewController.instantiate(for: TodoListViewModel())
        mainViewController.viewControllers = [viewController]

        UserDefaults.standard.setIsLoggedIn(set: true)

        dismiss(animated: true)
    }

    @IBAction func isLoggedInAction(_ sender: UIButton) {
        viewModel.updateLoggedIn(email: emailTextField.text!, password: passwordTextField.text!)

        let input = viewModel.logInInput()

        switch input {
        case .correct:
            viewModel.toLogIn()
        case .incorrect:
            return
        }
    }

    @IBAction func registerAction(_ sender: UIButton) {
        let viewController = RegisterViewController.instantiate(for: RegisterViewModel())
        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: true, completion: nil)
    }
}

extension LoggedInViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.returnKeyType == .next {
            emailTextField.resignFirstResponder()
            passwordTextField.becomeFirstResponder()
        } else if textField.returnKeyType == .done {
            passwordTextField.resignFirstResponder()
        }
        return true
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
