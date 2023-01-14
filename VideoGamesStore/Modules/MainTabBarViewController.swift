//
//  MainTabBarViewController.swift
//  VideoGamesStore
//
//  Created by Burak on 14.01.2023.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemYellow
        
        let home = UINavigationController(rootViewController: HomeViewController())
        let favorite = UINavigationController(rootViewController: FavoriteViewController())
        
        home.tabBarItem.image = UIImage(systemName: "house")
        favorite.tabBarItem.image = UIImage(systemName: "play.circle")
        
        home.title = "Home"
        favorite.title = "Coming Soon"
        
        tabBar.tintColor = .label
//        tabBar.isTranslucent = true
        
        setViewControllers([home, favorite], animated: true)
    }
}
