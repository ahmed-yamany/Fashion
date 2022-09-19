//
//  Login.swift
//  Fashion
//
//  Created by Ahmed Yamany on 19/09/2022.
//

import Foundation

// MARK: - Login
struct Login: Codable {
    var status: Bool?
    var message: String?
    var data: LoginData?
}

// MARK: - DataClass
struct LoginData: Codable {
    var id: Int?
    var name, email, phone: String?
    var image: String?
    var points, credit: Int?
    var token: String?
}
