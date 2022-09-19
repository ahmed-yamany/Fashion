//
//  Register.swift
//  Fashion
//
//  Created by Ahmed Yamany on 19/09/2022.
//

import UIKit

class RegisterRequest: APIRequest{
        
    typealias Response = Register
    
    var path: String = "register"
    var parameters: Dictionary<String, Any?>
    
    init(name: String, phone: String, email: String, password: String, image: UIImage?=nil){
        self.parameters = [
            "name": name,
            "phone": phone,
            "email": email,
            "password": password,
            "image": image?.pngData()
        ]
    }
}
