//
//  APIConstants.swift
//  VideoGamesStore
//
//  Created by Burak on 14.01.2023.
//

import Foundation
import UIKit

class APIConstants {
    private init() {}
    static private let API_KEY = "f84bf760719a40debecaa69826246e39"
    
    static func games(page: Int) -> String {
        "https://api.rawg.io/api/games?key=\(API_KEY)&page=\(page)"
        }
}

class UIColorConstants {
    private init() {}
    static let redColor = UIColor(named: "RedColor")
    static let lightRedColor = UIColor(named: "LightRedColor")
    static let creamColor = UIColor(named: "CreamColor")
    static let lightCreamColor = UIColor(named: "LightCreamColor")
}
