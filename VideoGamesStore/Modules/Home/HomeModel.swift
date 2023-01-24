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
    
    weak var delegate: HomeModelProtocol?
    
    private var page: Int = 0
    
    func fetchVideoGames() {
        self.page += 1
      if InternetManager.shared.isInternetActive() {
          AF.request(APIConstants.games(page: page)).responseDecodable(of: VideoGamesResponse.self) { (res) in
          guard let response = res.value
          else {
            self.delegate?.didVideoGamesCouldntfetch()
            return
          }
          self.delegate?.didVideoGamesfetch(videoGames: response.videoGames ?? [])
        }
      } else {
        ///Todo: Add Warning
        print("There is no Internet")
      }
    }
    
}
