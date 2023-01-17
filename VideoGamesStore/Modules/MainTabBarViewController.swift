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
        favorite.tabBarItem.image = UIImage(systemName: "heart")
        
        home.title = "Home"
        favorite.title = "Favorites"
        
        tabBar.barTintColor = UIColorConstants.creamColor
        tabBar.tintColor = UIColorConstants.redColor
        tabBar.unselectedItemTintColor = UIColorConstants.lightRedColor
        
        setViewControllers([home, favorite], animated: true)
    }
}
