//
//  LoginViewController.swift
//  Fashion
//
//  Created by Ahmed Yamany on 19/09/2022.
//

import UIKit

class LoginViewController: UIViewController {
    // MARK: - SubViews
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var securePasswordTFButton: UIButton!
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var forgotPasswordButton: UIButton!
    
    @IBOutlet weak var dontHaveAccountLabel: UILabel!
    @IBOutlet weak var signUpButton: UIButton!
    
    // MARK: - Properties
    private var isPasswordTextFieldHidden: Bool = true{
        didSet{
            if isPasswordTextFieldHidden{
                passwordTextField.isSecureTextEntry = true
                securePasswordTFButton.setImage(UIImage(systemName: "eye"), for: .normal)
            }else{
                passwordTextField.isSecureTextEntry = false
                securePasswordTFButton.setImage(UIImage(systemName: "eyebrow"), for: .normal)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordTextField.isSecureTextEntry = true
        emailTextField.delegate = self
        passwordTextField.delegate = self
        updateViewByLocalizedString()
        loginButton.layer.cornerRadius = 15

    }
    
    // MARK: - IBActions
    @IBAction func securePasswordButtonPressed(_ sender: UIButton) {
        isPasswordTextFieldHidden.toggle()
    }
    
    private func updateViewByLocalizedString(){
        let loginLocalizedString = NSLocalizedString("login", comment: "")
        let passwordLocalizedString = NSLocalizedString("password", comment: "")
        let emailLocalizedString = NSLocalizedString("email", comment: "")
        
        
        navigationItem.title = loginLocalizedString
        emailLabel.text = emailLocalizedString
        passwordLabel.text = passwordLocalizedString
        emailTextField.placeholder = emailLocalizedString
        passwordTextField.placeholder = passwordLocalizedString
        loginButton.setTitle(loginLocalizedString, for: .normal)
        forgotPasswordButton.setTitle(NSLocalizedString("forgotPassword", comment: ""), for: .normal)
        dontHaveAccountLabel.text = NSLocalizedString("dontHaveAccount", comment: "")
        signUpButton.setTitle(NSLocalizedString("signUp", comment: ""), for: .normal)
    }
    
}

// MARK: - UITextFieldDelegate
extension LoginViewController: UITextFieldDelegate{
    // this delegate method implements when return button is pressed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // whene return button is pressed select the next textField
        self.SelectNextTextFieldByCurrentSelectedTag(textField)
        return true
    }
    
    private func SelectNextTextFieldByCurrentSelectedTag(_ textField: UITextField){
        let nextTFTag = textField.tag + 1
        guard let nextTextField = self.view.viewWithTag(nextTFTag) as? UITextField else{
            self.view.endEditing(true)
            return
        }
        nextTextField.becomeFirstResponder()
    }
    
    
}
