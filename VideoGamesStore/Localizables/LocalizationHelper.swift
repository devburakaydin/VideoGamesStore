//
//  LocalizationHelper.swift
//  VideoGamesStore
//
//  Created by Burak on 21.01.2023.
//

import Foundation

enum LocalizationHelper: String {
    case notes
    case edit
    case addNote
    case warning
    case noteCannotBeBlankOrLessThan3Letters
    case ok
    case home
    case favorites
    case search
    case delete
    case searchForAVideoGames
    
    var localized: String {
        NSLocalizedString(String(describing: Self.self) + "_\(rawValue)", comment: "")
    }
}
