//
//  AuthorizationViewController.swift
//  HSE Apple
//
//  Created by Ксения Демиденко on 08.02.2022.
//

import UIKit

class AuthorizationViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordView: UIView!
    var loginVCDelegate: LoginViewControllerDelegate!
    
    var checkField = CheckField.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let press = UITapGestureRecognizer(target: self, action: #selector(keyboardPressedOutside))
        view.addGestureRecognizer(press)
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    @objc func keyboardPressedOutside() {
        self.view.endEditing(true)
    }

    @IBAction func closeButtonClick(_ sender: Any) {
        if loginVCDelegate != nil {
            loginVCDelegate.closeVC()
        }
    }
    
    @IBAction func authorizationButtonClick(_ sender: Any) {
        if checkField.validField(emailView, emailTextField),
           checkField.validField(passwordView, passwordTextField) {

                let applicationViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "ApplicationViewController")
                let navigationVC = UINavigationController(rootViewController: applicationViewController)
                navigationVC.modalPresentationStyle = .fullScreen
                self.present(navigationVC, animated: true, completion: nil)
            
           
        }
    }
    
    @IBOutlet weak var showPasswordButton: UIButton!
    @IBAction func showPasswordButtonClick(_ sender: Any) {
        if passwordTextField.isSecureTextEntry == true {
            passwordTextField.isSecureTextEntry = false
            showPasswordButton.setImage(UIImage.init(systemName: "eye.slash"), for: .normal)
        } else {
            passwordTextField.isSecureTextEntry = true
            showPasswordButton.setImage(UIImage.init(systemName: "eye.fill"), for: .normal)
        }
    }
    
    @IBAction func noAccountButtonClick(_ sender: Any) {
        loginVCDelegate.closeVC()
        loginVCDelegate.openRegistrationVC()
    }
}
extension AuthorizationViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        
    }
}
