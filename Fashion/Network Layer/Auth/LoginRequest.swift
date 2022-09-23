//
//  LoginRequest.swift
//  Fashion
//
//  Created by Ahmed Yamany on 19/09/2022.
//

import Foundation
import Alamofire

class LoginRequest: APIRequest{
    typealias Response = Login
    
    var path: String = "login"
    var parameters: Alamofire.Parameters?
    init(email: String, password: String){
        self.parameters = [
            "email": email,
            "password": password
        ]
    }
}
