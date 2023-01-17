//
//  HomeViewModel.swift
//  VideoGamesStore
//
//  Created by Burak on 14.01.2023.
//

import Foundation

protocol HomeViewModelDelegate: AnyObject {
    func refreshVideoGames()
    func changeFilter(isAToZ: Bool)
}

class HomeViewModel {
    
    var videoGames: [VideoGame] = []
    
    var isAToZ: Bool = true
    
    private let model: HomeModel = HomeModel()
    
    weak var delegate: HomeViewModelDelegate?
    
    init(){
        model.delegate = self
    }
    
    func didViewLoad() {
        model.fetchVideoGames()
    }
    
    func changeFilter(){
        isAToZ = !isAToZ
        videoGames = isAToZ ? videoGames.sorted { $0.name!.lowercased() < $1.name!.lowercased() }
                            : videoGames.sorted { $0.name!.lowercased() > $1.name!.lowercased() }
        self.delegate?.refreshVideoGames()
        delegate?.changeFilter(isAToZ: isAToZ)
    }
    
}

extension HomeViewModel: HomeModelProtocol{
    func didVideoGamesfetch(videoGames: [VideoGame]) {
        self.videoGames.append(contentsOf: videoGames)
        self.delegate?.refreshVideoGames()
    }
    
    func didVideoGamesCouldntfetch() {
        ///Todo : Add Warning
        print("Dont Video Game Fetch")
    }
    
    
}
