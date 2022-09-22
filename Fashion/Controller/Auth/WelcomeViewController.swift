//
//  WelcomeViewController.swift
//  Fashion
//
//  Created by Ahmed Yamany on 19/09/2022.
//

import UIKit
import SwiftKeychainWrapper

class WelcomeViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        guard let _ = KeychainWrapper.standard.string(forKey: AuthData.userToken) else{return}
        self.presentTabBarController()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        welcomeLabel.text = NSLocalizedString("welcomeLabel", comment: "")
        signUpButton.setTitle(NSLocalizedString("signUp", comment: ""), for: .normal)
        loginButton.setTitle(NSLocalizedString("login", comment: ""), for: .normal)
        loginButton.layer.cornerRadius = 20
        signUpButton.layer.cornerRadius = 20
    }
    
    private func presentTabBarController(){
        guard let tabBarVC = storyboard?.instantiateViewController(withIdentifier: TabBarViewController.identefier) else{return}
        
        tabBarVC.modalPresentationStyle = .fullScreen
        self.present(tabBarVC, animated: true)
    }
}
