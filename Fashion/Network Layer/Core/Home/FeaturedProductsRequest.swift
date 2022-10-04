//
//  FeaturedProductsRequest.swift
//  Fashion
//
//  Created by Ahmed Yamany on 24/09/2022.
//

import Foundation

import Alamofire

class FeaturedProductsReaquest: APIRequest{
    
    typealias Response = Products

    var path: String = "products"
    
    var parameters: Alamofire.Parameters? = nil
}
