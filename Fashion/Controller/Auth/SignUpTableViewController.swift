//
//  SignUpTableViewController.swift
//  Fashion
//
//  Created by Ahmed Yamany on 21/09/2022.
//

import UIKit

class SignUpTableViewController: UITableViewController {
    private lazy var manage = UIViewControllerManager(viewContoller: self)
    
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

    
    @IBOutlet weak var tableViewCell: UITableViewCell!
    override func viewDidLoad() {
        super.viewDidLoad()
        signUpButton.layer.cornerRadius = 20
        tableView.backgroundColor = .clear
        tableViewCell.backgroundColor = .clear
        usernameTextField.delegate = self
        mobileNumberTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        self.updateViewByLocalizeingStings()
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
    
    
    @IBAction func endEditingGesture(_ sender: UITapGestureRecognizer) {
        self.tableViewCell.contentView.endEditing(true)
    }
    
}

extension SignUpTableViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.manage.SelectNextTextFieldByTagOrEndEditing(textField)
        return true
    }
}
