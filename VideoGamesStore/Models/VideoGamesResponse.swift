//
//  VideoGamesResponse.swift
//  VideoGamesStore
//
//  Created by Burak on 14.01.2023.
//

import Foundation

// MARK: - VideoGamesResponse
struct VideoGamesResponse: Codable {
    let videoGames: [VideoGame]?

    enum CodingKeys: String, CodingKey {
        case videoGames = "results"
    }
}

// MARK: - Result
struct VideoGame: Codable {
    let id: Int?
    let name, released: String?
    let backgroundImage: String?
    let rating: Double?
    let suggestionsCount: Int?

    enum CodingKeys: String, CodingKey {
        case id, name, released
        case backgroundImage = "background_image"
        case rating
        case suggestionsCount = "suggestions_count"
    }
}
