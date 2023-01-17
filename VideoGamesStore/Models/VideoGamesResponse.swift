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
    let slug, name, released: String?
    let tba: Bool?
    let backgroundImage: String?
    let rating: Double?
    let ratingTop: Int?
    let ratingsCount, reviewsTextCount, added: Int?
    let metacritic, playtime, suggestionsCount: Int?
    let updated: String?
    let userGame: String?
    let reviewsCount: Int?

    enum CodingKeys: String, CodingKey {
        case id, slug, name, released, tba
        case backgroundImage = "background_image"
        case rating
        case ratingTop = "rating_top"
        case ratingsCount = "ratings_count"
        case reviewsTextCount = "reviews_text_count"
        case added
        case metacritic, playtime
        case suggestionsCount = "suggestions_count"
        case updated
        case userGame = "user_game"
        case reviewsCount = "reviews_count"
    }
}
