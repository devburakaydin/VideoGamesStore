//
//  DetailModel.swift
//  VideoGamesStore
//
//  Created by Burak on 20.01.2023.
//

import Foundation

protocol DetailModeldelegate: AnyObject {
    func updateFavoriteItem(favoriteItem: FavoriteItem?)
}

class DetailModel {
    weak var delegate: DetailModeldelegate?
    
    init(){}
    
    func favoriteControl(id: Int?){
        CoreDataManager.shared.getFavoritesVideoGames { [weak self] videoGames in
            let favoriteItem = videoGames.first { item in
                Int(item.id) == id
            }
            self?.delegate?.updateFavoriteItem(favoriteItem: favoriteItem)
        }
    }
    
    func addFavorite(videoGame: VideoGame){
        CoreDataManager.shared.saveVideoGameToFavorites(model: videoGame) { [weak self] favoriteItem in
            self?.delegate?.updateFavoriteItem(favoriteItem: favoriteItem)
        }
    }
    
    func deleteFavorite(favoriteItem: FavoriteItem){
        CoreDataManager.shared.deleteFavorite(model: favoriteItem) { [weak self] state in
            if(state){
                self?.delegate?.updateFavoriteItem(favoriteItem: nil)
            }
        }
    }
}
