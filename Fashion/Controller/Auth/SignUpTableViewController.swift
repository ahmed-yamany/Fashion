//
//  SignUpTableViewController.swift
//  Fashion
//
//  Created by Ahmed Yamany on 21/09/2022.
//

import UIKit

class SignUpTableViewController: UITableViewController {
    // MARK: - Properties
    private lazy var manage = UIViewControllerManager(viewContoller: self)
    let activityIndicatorView = UIActivityIndicatorView(style: .medium)
    
    // MARK: - IBOutlets
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var mobileNumberLabel: UILabel!
    @IBOutlet weak var mobileNumberTextField: UITextField!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var alreadyMemberButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!

    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var tableViewCell: UITableViewCell!
    
    // MARK: - Views
    override func viewDidLoad() {
        super.viewDidLoad()
        signUpButton.layer.cornerRadius = 20
        self.clearTableViewBackgroudColor()
        self.setSelfEqualTextFieldsDelegate()
        self.updateViewByLocalizeingStings()
    }
    private func clearTableViewBackgroudColor(){
        tableView.backgroundColor = .clear
        tableViewCell.backgroundColor = .clear
    }
    private func setSelfEqualTextFieldsDelegate(){
        usernameTextField.delegate = self
        mobileNumberTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    private func updateViewByLocalizeingStings(){
        let signUpLocalizeString = NSLocalizedString("signUp", comment: "")
        let usernameString = NSLocalizedString("username", comment: "")
        let mobileNumberString = NSLocalizedString("phoneNumber", comment: "")
        let emailString = NSLocalizedString("email", comment: "")
        let passwordString = NSLocalizedString("password", comment: "")
        usernameLabel.text = usernameString
        usernameTextField.placeholder = usernameString
        mobileNumberLabel.text = mobileNumberString
        mobileNumberTextField.placeholder = mobileNumberString
        emailLabel.text = emailString
        emailTextField.placeholder = emailString
        passwordLabel.text = passwordString
        passwordTextField.placeholder = passwordString
        signUpButton.setTitle(signUpLocalizeString, for: .normal)
        alreadyMemberButton.setTitle(NSLocalizedString("alreadyMemberButton", comment: ""), for: .normal)
    }
  
    // MARK: - IBActions
    @IBAction func dismissKeyboardWhenUserTabsAnyPlace(_ sender: UITapGestureRecognizer) {
        self.tableView.endEditing(true)
    }
    @IBAction func alredyMemberButtonTapped(_ sender: UIButton) {
        guard let loginVC = storyboard?.instantiateViewController(withIdentifier: LoginViewController.storyboardID) else{return}
        navigationController?.pushViewController(loginVC, animated: true)
    }
    @IBAction func signUPButtonTapped(_ sender: UIButton) {
        setUpActivityIndecatorAndStartIt()
        createNetworkRequestAndStopActivityIndicatior()
    }
    
    // MARK: - Private functions
    private func setUpActivityIndecatorAndStartIt(){
        let w = UIScreen.main.bounds.width
        let h = UIScreen.main.bounds.height
        
        self.activityIndicatorView.center = CGPoint(x: w/2, y: h/3)
        self.view.addSubview(self.activityIndicatorView)
        self.activityIndicatorView.startAnimating()
    }
    private func createNetworkRequestAndStopActivityIndicatior(){
        let name = usernameTextField.text ?? ""
        let phone = mobileNumberTextField.text ?? ""
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        let registerRequest = RegisterRequest(name: name, phone: phone, email: email, password: password)
        registerRequest.send { [weak self] result in
            self?.activityIndicatorView.stopAnimating()
            switch result{
            case .success(let value):
                self?.checkNetworkResultStatus(value)
            case .failure(let error):
                self?.showErrorMessage(error.localizedDescription)
            }
        }
    }
    private func checkNetworkResultStatus(_ result: Register?){
        guard let value = result, let status = value.status, let message = value.message else {return}
        if status{
            self.errorLabel.text = ""
            self.setLoginViewControllerFirstNavigationController()
        }else{
            self.showErrorMessage(message)
        }
    }
    private func setLoginViewControllerFirstNavigationController(){
        guard let loginVC = self.storyboard?.instantiateViewController(withIdentifier: LoginViewController.storyboardID) else{return}
        guard let root = self.navigationController?.viewControllers.first else{return}
        
        self.navigationController?.setViewControllers([root, loginVC], animated: true)
        
    }
    private func showErrorMessage(_ message: String){
        self.errorLabel.text = message

    }
}

// MARK: - UITextFieldDelegate
extension SignUpTableViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.manage.selectNextTextFieldByTagOrEndEditing(textField)
        return true
    }
}
