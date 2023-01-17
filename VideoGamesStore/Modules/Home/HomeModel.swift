//
//  HomeModel.swift
//  VideoGamesStore
//
//  Created by Burak on 14.01.2023.
//

import Foundation
import Alamofire

protocol HomeModelProtocol : AnyObject{
    func didVideoGamesfetch(videoGames:[VideoGame])
    func didVideoGamesCouldntfetch()
}

class HomeModel {
    
    private(set) var videoGames: [VideoGame] = []
    
    weak var delegate: HomeModelProtocol?
    
    private var page: Int = 1
    
    func fetchVideoGames() {
        self.page += 1
      if InternetManager.shared.isInternetActive() {
          AF.request(APIConstants.games(page: page)).responseDecodable(of: VideoGamesResponse.self) { (res) in
          guard let response = res.value
          else {
            self.delegate?.didVideoGamesCouldntfetch()
            return
          }
          self.videoGames.append(contentsOf: response.videoGames ?? [])
          self.delegate?.didVideoGamesfetch(videoGames: self.videoGames)
        }
      } else {
        ///Todo: Add Warning
        print("There is no Internet")
      }
    }
    
}
