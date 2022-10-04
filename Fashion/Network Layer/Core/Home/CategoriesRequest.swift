//
//  CategoriesRequest.swift
//  Fashion
//
//  Created by Ahmed Yamany on 23/09/2022.
//

import Foundation
import Alamofire

class CategoriesReaquest: APIRequest{
    
    typealias Response = Categories

    var path: String = "categories"
    
    var parameters: Alamofire.Parameters? = nil
}
