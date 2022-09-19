//
//  Logout.swift
//  Fashion
//
//  Created by Ahmed Yamany on 19/09/2022.
//

import Foundation
// MARK: - Login
struct Logout: Codable {
    var status: Bool?
    var message: String?
    var data: LogoutData?
}

// MARK: - DataClass
struct LogoutData: Codable {
    var id: Int?
    var token: String?
}

