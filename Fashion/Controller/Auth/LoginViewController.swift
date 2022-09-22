//
//  LoginViewController.swift
//  Fashion
//
//  Created by Ahmed Yamany on 19/09/2022.
//

import UIKit
import SwiftKeychainWrapper

class LoginViewController: UIViewController {
    // MARK: - Properties
    static let storyboardID = "LoginViewController"
    private var isPasswordTextFieldHidden: Bool = true{
        didSet{
            if isPasswordTextFieldHidden{
                passwordTextField.isSecureTextEntry = true
                securePasswordTFButton.setImage(UIImage(systemName: "eye"), for: .normal)
            }else{
                passwordTextField.isSecureTextEntry = false
                securePasswordTFButton.setImage(UIImage(systemName: "eyebrow"), for: .normal)
            }}}
    private lazy var manager = UIViewControllerManager(viewContoller: self)
    let activityIndicatorView = UIActivityIndicatorView(style: .medium)
    
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
    
    @IBOutlet weak var errorLabel: UILabel!
    
    // MARK: - Views
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
        passwordTextField.delegate = self
        updateViewByLocalizedString()
        loginButton.layer.cornerRadius = 20
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

    
    // MARK: - IBActions
    @IBAction func securePasswordButtonPressed(_ sender: UIButton) {
        isPasswordTextFieldHidden.toggle()
    }
    
    @IBAction func dismissKeyboardWhenUserTabsAnyPlace(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    @IBAction func signUpButtonTapped(_ sender: UIButton) {
        guard let signUpVC = storyboard?.instantiateViewController(withIdentifier: SignUpViewController.storyboardID) else{return}
        navigationController?.pushViewController(signUpVC, animated: true)
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        setUpActivityIndicatorAndStartIt()
        networkRequestAndStopActivityIndicator()
    }
    
    private func setUpActivityIndicatorAndStartIt(){
        let w = UIScreen.main.bounds.width
        let h = UIScreen.main.bounds.height
        
        self.activityIndicatorView.center = CGPoint(x: w/2, y: h/3)
        self.view.addSubview(self.activityIndicatorView)
        self.activityIndicatorView.startAnimating()
    }
    
    private func networkRequestAndStopActivityIndicator(){
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        let request = LoginRequest(email: email, password: password)

        request.send { [weak self] result in
            self?.activityIndicatorView.stopAnimating()
            switch result{
            case .success(let result):
                self?.checkNetworkResultStatus(result)
            case .failure(let error):
                self?.showErrorMessage(error.localizedDescription)
            }
        }
    }
    
    private func checkNetworkResultStatus(_ result: Login?){
        guard let result = result, let status = result.status, let message = result.message else{return}
        if status{
            guard let data = result.data else{return}
            self.errorLabel.text = ""
            self.saveAuthDataToCach(data)
            self.presentTabBarController()
        }else{
            showErrorMessage(message)
        }
    }
    
    private func showErrorMessage(_ message: String){
        self.errorLabel.text = message
    }
    
    private func saveAuthDataToCach(_ data: AuthData){
        guard let token = data.token else{return}
        KeychainWrapper.standard.set(token, forKey: AuthData.userToken)
        
        let userDefaults = UserDefaults.standard
        userDefaults.setValue(data.name, forKey: AuthData.userName)
        userDefaults.set(data.phone, forKey: AuthData.userPhone)
        userDefaults.set(data.email, forKey: AuthData.userEmail)
        userDefaults.set(data.id, forKey: AuthData.userId)
        userDefaults.set(data.image, forKey: AuthData.userImage)
    }
    private func presentTabBarController(){
        guard let tabBarVC = storyboard?.instantiateViewController(withIdentifier: TabBarViewController.identefier) else{return}
        tabBarVC.modalPresentationStyle = .fullScreen
        self.present(tabBarVC, animated: true)
    }
}

// MARK: - UITextFieldDelegate
extension LoginViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // whene return button is pressed select the next textField
        self.manager.selectNextTextFieldByTagOrEndEditing(textField)
        return true
    }
    
}
