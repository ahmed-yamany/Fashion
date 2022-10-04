//
//  Products.swift
//  Fashion
//
//  Created by Ahmed Yamany on 24/09/2022.
//

import Foundation

struct Products: Codable {
    var status: Bool?
    var message: String?
    var data: ProductsClass?
}

// MARK: - DataClass
struct ProductsClass: Codable {
    var currentPage: Int?
    var products: [Product]?
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
        case products = "data"
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

// MARK: - Datum
struct Product: Codable, Hashable {
    var id: Int?
    var price, oldPrice: Double?
    var discount: Int?
    var image: String?
    var name, datumDescription: String?
    var images: [String]?
    var inFavorites, inCart: Bool?

    enum CodingKeys: String, CodingKey {
        case id, price
        case oldPrice = "old_price"
        case discount, image, name
        case datumDescription = "description"
        case images
        case inFavorites = "in_favorites"
        case inCart = "in_cart"
    }
}
