//
//  RegistrationViewController.swift
//  HSE Apple
//
//  Created by Ксения Демиденко on 08.02.2022.
//

import UIKit

class RegistrationViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var repeatPasswordView: UIView!
    
    var loginVCDelegate: LoginViewControllerDelegate!
    
    var checkField = CheckField.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let press = UITapGestureRecognizer(target: self,
                                           action: #selector(keyboardPressedOutside))
        view.addGestureRecognizer(press)
        emailTextField.delegate = self
        passwordTextField.delegate = self
        repeatPasswordTextField.delegate = self
    }
    
    @IBAction func closeButtonClick(_ sender: Any) {
        if loginVCDelegate != nil {
            loginVCDelegate.closeVC()
        }
    }
    @objc func keyboardPressedOutside() {
        self.view.endEditing(true)
    }
    
    @IBAction func registrationButtonClick(_ sender: Any) {
        if checkField.validField(emailView, emailTextField),
            checkField.validField(passwordView, passwordTextField) {
            if (passwordTextField.text == repeatPasswordTextField.text) {
                let alert = UIAlertController(title: "Успешно!", message: "Запрос на регистрацию отправлен!", preferredStyle: .alert)
                let okButton = UIAlertAction(title: "OK", style: .default) {_ in self.loginVCDelegate.closeVC()}
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
            } else {
                let alert = UIAlertController(title: "Ошибка", message: "Пароли не совпадают!", preferredStyle: .alert)
                let okButton = UIAlertAction(title: "OK", style: .default) {_ in}
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func alreadyHasButtonClick(_ sender: Any) {
        loginVCDelegate.closeVC();
        loginVCDelegate.openAuthorizationVC();
    }
    
    @IBOutlet weak var showPasswordButton: UIButton!
    @IBAction func showPasswordButtonClick(_ sender: Any) {
        if passwordTextField.isSecureTextEntry == true &&
            repeatPasswordTextField.isSecureTextEntry == true {
            passwordTextField.isSecureTextEntry = false
            repeatPasswordTextField.isSecureTextEntry = false
            showPasswordButton.setImage(UIImage.init(systemName: "eye.slash"), for: .normal)
        } else {
            passwordTextField.isSecureTextEntry = true
            repeatPasswordTextField.isSecureTextEntry = true
            showPasswordButton.setImage(UIImage.init(systemName: "eye.fill"), for: .normal)
        }
    }
}
extension RegistrationViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        
    }
}
