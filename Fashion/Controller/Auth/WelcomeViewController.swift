//
//  WelcomeViewController.swift
//  Fashion
//
//  Created by Ahmed Yamany on 19/09/2022.
//

import UIKit

class WelcomeViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.layer.cornerRadius = 20
        signUpButton.layer.cornerRadius = 20
        setViewLocalizedStrings()
    }
    
    private func setViewLocalizedStrings(){
        welcomeLabel.text = NSLocalizedString("welcomeLabel", comment: "")
        signUpButton.setTitle(NSLocalizedString("signUp", comment: ""), for: .normal)
        loginButton.setTitle(NSLocalizedString("login", comment: ""), for: .normal)
    }
}
