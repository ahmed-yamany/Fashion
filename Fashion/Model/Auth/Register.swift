//
//  Register.swift
//  Fashion
//
//  Created by Ahmed Yamany on 19/09/2022.
//

import Foundation

// MARK: - Register
struct Register: Codable {
    var status: Bool?
    var message: String?
    var data: AuthData?
}

struct AuthData: Codable {
    static let userToken = "token"
    static let userName = "name"
    static let userEmail = "email"
    static let userPhone = "phone"
    static let userImage = "image"
    static let userId = "userId"
    
    var id: Int?
    var name, email, phone: String?
    var image: String?
    var points, credit: Int?
    var token: String?
}
