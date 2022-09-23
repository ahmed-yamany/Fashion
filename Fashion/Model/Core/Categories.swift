//
//  Categories.swift
//  Fashion
//
//  Created by Ahmed Yamany on 23/09/2022.
//

import Foundation

// MARK: - Categories
struct Categories: Codable {
    var status: Bool?
    var message: String?
    var data: DataClass?
}

// MARK: - DataClass
struct DataClass: Codable {
    var currentPage: Int?
    var categories: [Category]?
    var firstPageURL: String?
    var from, lastPage: Int?
    var lastPageURL: String?
    var nextPageURL: String?
    var path: String?
    var perPage: Int?
    var prevPageURL: String?
    var to, total: Int?

    enum CodingKeys: String, CodingKey {
        case currentPage = "current_page"
        case categories = "data"
        case firstPageURL = "first_page_url"
        case from
        case lastPage = "last_page"
        case lastPageURL = "last_page_url"
        case nextPageURL = "next_page_url"
        case path
        case perPage = "per_page"
        case prevPageURL = "prev_page_url"
        case to, total
    }
}

// MARK: - Category
struct Category: Codable {
    var id: Int?
    var name: String?
    var image: String?
}

