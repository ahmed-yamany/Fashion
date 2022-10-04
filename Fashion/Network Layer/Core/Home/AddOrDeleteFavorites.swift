//
//  AddOrDeleteFavorites.swift
//  Fashion
//
//  Created by Ahmed Yamany on 02/10/2022.
//

import Foundation
import Alamofire

class AddOrDeleteFavoritesRequest: APIRequest{
    typealias Response = Favorites
    
    var path: String = "favorites"
    
    var parameters: Alamofire.Parameters?
    init(productId: Int){
        self.parameters = [
            "product_id": productId
        ]
    }
    
    
}
