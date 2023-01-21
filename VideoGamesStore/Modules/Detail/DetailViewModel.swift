//
//  DetailViewModel.swift
//  VideoGamesStore
//
//  Created by Burak on 20.01.2023.
//

import Foundation

protocol DetailViewModelDelegate: AnyObject {
    func updateFavoriteIcon()
}

class DetailViewModel {
    
    weak var delegate: DetailViewModelDelegate?
    
    var videoGame: VideoGame?
    
    var favoriteItem: FavoriteItem?
    
    private let model: DetailModel = DetailModel()
    
    init(){
        model.delegate = self
    }
    
    func favoriteControl(){
        model.favoriteControl(id: videoGame?.id)
    }
    
    
    func onTapFavorite(){
        if(favoriteItem == nil) {
            model.addFavorite(videoGame: videoGame!)
        }else{
            model.deleteFavorite(favoriteItem: favoriteItem!)
        }
    }
    
}

extension DetailViewModel: DetailModeldelegate {
    func updateFavoriteItem(favoriteItem: FavoriteItem?) {
        self.favoriteItem = favoriteItem
        self.delegate?.updateFavoriteIcon()
        NotificationCenter.default.post(name: NSNotification.Name("favorite"), object: nil)
    }
    
    
}
