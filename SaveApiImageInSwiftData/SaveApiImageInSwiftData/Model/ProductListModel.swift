//
//  ProductListModel.swift
//  SaveApiImageInSwiftData
//
//  Created by Priyanka Mathur on 08/05/24.
//

import Foundation
import SwiftData

class ProductListModel: Decodable {
    
    let products: [Products]
    let total: Int
    let skip: Int
    let limit: Int
    
    private enum CodingKeys: String, CodingKey {
        case products = "products"
        case total = "total"
        case skip = "skip"
        case limit = "limit"
    }
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        products = try values.decode([Products].self, forKey: .products)
        total = try values.decode(Int.self, forKey: .total)
        skip = try values.decode(Int.self, forKey: .skip)
        limit = try values.decode(Int.self, forKey: .limit)
    }
}

@Model class Products: Decodable {
    
    @Attribute(.unique)
    let id: Int
    let title: String
    let descriptions: String
    let price: Int
    let discountPercentage: Double
    let rating: Double
    let stock: Int
    let brand: String
    let category: String
    let thumbnail: String
    let images: [String]

    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case descriptions = "description"
        case price = "price"
        case discountPercentage = "discountPercentage"
        case rating = "rating"
        case stock = "stock"
        case brand = "brand"
        case category = "category"
        case thumbnail = "thumbnail"
        case images = "images"
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        title = try values.decode(String.self, forKey: .title)
        descriptions = try values.decode(String.self, forKey: .descriptions)
        price = try values.decode(Int.self, forKey: .price)
        discountPercentage = try values.decode(Double.self, forKey: .discountPercentage)
        rating = try values.decode(Double.self, forKey: .rating)
        stock = try values.decode(Int.self, forKey: .stock)
        brand = try values.decode(String.self, forKey: .brand)
        category = try values.decode(String.self, forKey: .category)
        thumbnail = try values.decode(String.self, forKey: .thumbnail)
        images = try values.decode([String].self, forKey: .images)
    }

}
