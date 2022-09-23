//
//  LogoutRequest.swift
//  Fashion
//
//  Created by Ahmed Yamany on 19/09/2022.
//

import Foundation
import Alamofire
class LogoutRequest: APIRequest{
    typealias Response = Logout
    
    var path: String = "logout"
    var parameters: Alamofire.Parameters? = nil

    
}
