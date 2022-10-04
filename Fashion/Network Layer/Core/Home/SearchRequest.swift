//
//  SearchRequest.swift
//  Fashion
//
//  Created by Ahmed Yamany on 04/10/2022.
//

import Foundation
import Alamofire

class SearchRequest: APIRequest{
    typealias Response = Products

    var path: String = "products/search"
    
    var parameters: Alamofire.Parameters?
    init(text: String){
        self.parameters = [
            "text": text
        ]
    }
}
