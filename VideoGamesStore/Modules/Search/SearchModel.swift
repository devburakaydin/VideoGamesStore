//
//  SearchModel.swift
//  VideoGamesStore
//
//  Created by Burak on 17.01.2023.
//

import Foundation
import Alamofire

protocol SearchModelDelegate : AnyObject{
    func didSearchVideoGamesfetch(videoGames: [VideoGame])
    func didSearchVideoGamesCouldntfetch()
}

class SearchModel {
    
    weak var delegate: SearchModelDelegate?
    
    func fetchSearchVideoGames(query: String) {
      if InternetManager.shared.isInternetActive() {
          AF.request(APIConstants.search(query: query)).responseDecodable(of: VideoGamesResponse.self) { (res) in
          guard let response = res.value
          else {
              self.delegate?.didSearchVideoGamesCouldntfetch()
              return
          }
              self.delegate?.didSearchVideoGamesfetch(videoGames: response.videoGames ?? [])
        }
      } else {
        ///Todo: Add Warning
        print("There is no Internet")
      }
    }
    
}
