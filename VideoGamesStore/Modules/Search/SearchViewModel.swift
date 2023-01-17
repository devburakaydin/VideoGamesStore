//
//  SearchViewModel.swift
//  VideoGamesStore
//
//  Created by Burak on 17.01.2023.
//

import Foundation

protocol SearchViewModelDelegate: AnyObject {
    func refreshSearch()
}

class SearchViewModel {
    
    weak var delegate: SearchViewModelDelegate?
    
    private let model: SearchModel = SearchModel()
    
    var videoGamesResult: [VideoGame] = []
    
    init(){
        model.delegate = self
    }
    
    func search(query: String) {
        model.fetchSearchVideoGames(query: query);
    }
    
}

extension SearchViewModel: SearchModelDelegate {
    func didSearchVideoGamesfetch(videoGames: [VideoGame]) {
        videoGamesResult = videoGames
        self.delegate?.refreshSearch()
    }
    
    func didSearchVideoGamesCouldntfetch() {
        ///Todo : Add Warning
        print("Dont Video Game Fetch")
    }
    
    
}
