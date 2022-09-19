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
    var data: RegisterData?
}

// MARK: - DataClass
struct RegisterData: Codable {
    var name, phone, email: String?
    var id: Int?
    var image: String?
    var token: String?
}
