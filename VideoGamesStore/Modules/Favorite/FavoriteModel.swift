//
//  FavoriteModel.swift
//  VideoGamesStore
//
//  Created by Burak on 20.01.2023.
//

import Foundation

protocol FavoriteModelDelegate: AnyObject {
    func getfavorites(favorites: [FavoriteItem])
    
}

class FavoriteModel {
    weak var delegate: FavoriteModelDelegate?
    
    init(){}
    
    func getFavorites(){
        CoreDataManager.shared.getFavoritesVideoGames { [weak self] favoriteItems in
            self?.delegate?.getfavorites(favorites: favoriteItems)
        }
    }
    
    func deleteFavorite(item: FavoriteItem){
        CoreDataManager.shared.deleteFavorite(model: item) { [weak self] state in
            if(!state) { return }
            self?.getFavorites()
        }
    }
}
