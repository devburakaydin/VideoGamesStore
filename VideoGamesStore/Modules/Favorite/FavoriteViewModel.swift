//
//  FavoriteViewModel.swift
//  VideoGamesStore
//
//  Created by Burak on 20.01.2023.
//

import Foundation

protocol FavoriteViewModelDelegate: AnyObject {
    func updateFavoriteList()
}

class FavoriteViewModel {
    private let model: FavoriteModel = FavoriteModel()
    
    weak var delegate: FavoriteViewModelDelegate?
    
    var favorites: [FavoriteItem] = [FavoriteItem]()
    
    init(){
        model.delegate = self
    }
    
    func getFavorites(){
        model.getFavorites()
    }
    
    func deleteFavorites(index: Int){
        model.deleteFavorite(item: favorites[index])
    }
}

extension FavoriteViewModel: FavoriteModelDelegate {
    func getfavorites(favorites: [FavoriteItem]) {
        self.favorites = favorites
        self.delegate?.updateFavoriteList()
    }
}
