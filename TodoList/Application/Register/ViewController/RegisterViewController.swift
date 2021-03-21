import UIKit
import SkyFloatingLabelTextField

class RegisterViewController: UIViewController {

    lazy var viewModel: RegisterViewModel = {
        return RegisterViewModel()
    }()

    static func instantiate(for viewModel: RegisterViewModel) -> RegisterViewController {
        let storyboard = UIStoryboard(name: .main, bundle: .main)
        let viewController = storyboard.instantiate(RegisterViewController.self)
        viewController.viewModel = viewModel
        return viewController
    }

    @IBOutlet weak var nameTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var emailTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var passwordTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var ageTextField: SkyFloatingLabelTextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTextFieldState()
        bindViewModel()
    }

    private func setupUI() {
        passwordTextField.enablePasswordToggle()

        nameTextField.delegate = self
        ageTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }

    private func setupTextFieldState() {
        viewModel.registerInputErrorMessage.bind { [weak self] isEmpty in
            self?.emailTextField.errorMessage = "Please enter your Email."
            self?.passwordTextField.errorMessage = "Please enter your Password."
            self?.ageTextField.errorMessage = "Please enter your Age."
            self?.nameTextField.errorMessage = "Please enter your Name."
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

        viewModel.isNameTextFieldEmpty.bind { [weak self] isEmpty in
            DispatchQueue.main.async {
                guard let isEmpty = isEmpty else { return }
                if isEmpty {
                    self?.nameTextField.selectedLineColor = .red
                }
            }
        }

        viewModel.isAgeTextFieldEmpty.bind { [weak self] isEmpty in
            DispatchQueue.main.async {
                guard let isEmpty = isEmpty else { return }
                if isEmpty {
                    self?.ageTextField.selectedLineColor = .red
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

        viewModel.isRegisterSuccessful.bind { [weak self] isSuccessful in
            DispatchQueue.main.async {
                guard let isSuccessful = isSuccessful else { return }
                if isSuccessful {
                    self?.isRegisterSuccessful()
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

    private func isRegisterSuccessful() {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func backAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func registerAction(_ sender: UIButton) {
        let name = nameTextField.text!
        let email = emailTextField.text!
        let password = passwordTextField.text!
        let age = Int(ageTextField.text!) ?? 1

        viewModel.updateRegister(name: name, email: email, password: password, age: age)
        let input = viewModel.registerInput()

        switch input {
        case .correct:
            viewModel.toRegister()
        case .incorrect:
            return
        }
    }
}

extension RegisterViewController: UITextFieldDelegate {
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

