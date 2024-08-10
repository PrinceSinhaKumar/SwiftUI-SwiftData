//
//  ListModel.swift
//  FunWithCodableProtocol
//
//  Created by  Prince Shrivastav on 10/08/24.
//

import Foundation
struct ListModel: Decodable {
    let name: String
    let language: String
    let id: String
    let bio: String
    let version: CustomVersionType
    let date: Date
    
    enum CodingKeys: String, CodingKey {
        case name, language, id, bio, version
        case date = "created_date"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.language = try container.decode(String.self, forKey: .language)
        self.id = try container.decode(String.self, forKey: .id)
        self.bio = try container.decode(String.self, forKey: .bio)
        self.version = try container.decodeIfPresent(CustomVersionType.self, forKey: .version) ?? .double(0)
        self.date = try container.decode(Date.self, forKey: .date)
    }
}

enum CustomVersionType: Codable {
    case string(String)
    case double(Double)
    
    init(from decoder: any Decoder) throws {
        if let dobleVal = try? decoder.singleValueContainer().decode(Double.self) {
            self = .double(dobleVal)
            return
        } else if let stringVal = try? decoder.singleValueContainer().decode(String.self) {
            self = .string(stringVal)
            return
        }
        throw ErrorHandler.fileNotAvailable
    }
}
