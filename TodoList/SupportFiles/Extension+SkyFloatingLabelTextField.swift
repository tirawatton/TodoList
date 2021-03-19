import SkyFloatingLabelTextField

extension SkyFloatingLabelTextField {
    @objc func setPasswordToggleImage(_ button: UIButton) {
        if isSecureTextEntry {
            button.setImage(UIImage(named: "eye"), for: .normal)
        } else {
            button.setImage(UIImage(named: "Group 1136"), for: .normal)
        }
    }

    func enablePasswordToggle() {
        let button = UIButton(type: .custom)
        setPasswordToggleImage(button)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
        button.frame = CGRect(x: CGFloat(self.frame.size.width - 25), y: CGFloat(5), width: CGFloat(25), height: CGFloat(25))
        button.addTarget(self, action: #selector(togglePasswordView), for: .touchUpInside)
        self.rightView = button
        self.rightViewMode = .always
    }

    @IBAction func togglePasswordView(_ sender: Any) {
        self.isSecureTextEntry = !self.isSecureTextEntry
        setPasswordToggleImage(sender as! UIButton)
    }
}
