//
//  LoginRequest.swift
//  Fashion
//
//  Created by Ahmed Yamany on 19/09/2022.
//

import Foundation

class LoginRequest: APIRequest{
    typealias Response = Login
    
    var path: String = "login"
    var parameters: Dictionary<String, Any?>
    init(email: String, password: String){
        self.parameters = [
            "email": email,
            "password": password
        ]
    }
}
