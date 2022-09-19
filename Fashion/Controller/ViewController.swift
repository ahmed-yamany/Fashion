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
        RegisterRequest(name: "ahmed", phone: "01094976111", email: "yamany@yamany.com", password: "123456789123").send { response in
            switch response{
            case .success(let response):
                print(response?.message)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }


}

