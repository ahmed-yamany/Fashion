//
//  ViewController.swift
//  Fashion
//
//  Created by Ahmed Yamany on 19/09/2022.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        let register = RegisterRequest(name: "ahmed", phone: "01094976111", email: "yamany@yamany.com", password: "123456789123")
        
//        let login = LoginRequest(email: "yamany@yamany.com", password: "123456789123")
//        UserDefaults.standard.set("hAZysMXxwft7zDdanbtjOz9eEZjFjXoWDjod38gkmUjOUAhqkddmQe1GEjEUH8aoc268Gh", forKey: "userToken")
        
        let logout = LogoutRequest()
        logout.send { response in
            switch response{
            case .success(let response):
                print(response)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }


}

