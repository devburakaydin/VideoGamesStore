//
//  DetailViewController.swift
//  VideoGamesStore
//
//  Created by Burak on 17.01.2023.
//

import UIKit

class DetailViewController: UIViewController {
    
    private var videoGame: VideoGame?

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func configure(videoGame: VideoGame) {
        self.videoGame = videoGame
    }

}
