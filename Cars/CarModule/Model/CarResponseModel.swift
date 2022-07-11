//
//  CarResponseModel.swift
//  Cars
//
//  Created by raviseta on 11/07/22.
//

import Foundation

// MARK: - Article
struct Car: Decodable {
    let status: String
    let content: [Content]
    let serverTime: Int
}

// MARK: - Content
struct Content: Decodable {
    
    let id: Int
    let title, dateTime: String
    let tags: [String]
    let content: [ContentDetail]
    let ingress: String
    let image: String
    let created, changed: Int
}

// MARK: - ContentDetail
struct ContentDetail: Codable {
    let type, subject, contentDescription: String

    enum CodingKeys: String, CodingKey {
        case type, subject
        case contentDescription = "description"
    }
}
