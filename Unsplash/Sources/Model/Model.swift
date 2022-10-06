//
//  Model.swift
//  Unsplash
//
//  Created by Илья Белкин on 29.09.2022.
//

import Foundation

enum Format {
    static let jpg = ".jpg"
}

struct Empty: Codable {
    let id: String?
    let createdAt: Date?
    let urls: Urls
    let likes: Int?
    let user: User?
    let location: Location?
    let downloads: Int?
}

struct Location: Codable {
    let city: String?
}

struct Position: Codable {
    let latitude, longitude: JSONNull?
}

struct User: Codable {
    let id: String?
    let name: String?
    let firstName: String?
    let lastName: String?
}

struct Urls: Codable {
    let raw, full, regular, small: String
    let thumb, smallS3: String
    
    enum CodingKeys: String, CodingKey {
        case raw, full, regular, small, thumb
        case smallS3 = "small_s3"
    }
}

class JSONNull: Codable, Hashable {
    
    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(0)
    }
    
    public init() {}
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
