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
        view.backgroundColor = UIColorConstants.creamColor
        
        let home = UINavigationController(rootViewController: HomeViewController())
        let search = UINavigationController(rootViewController: SearchViewController())
        let favorite = UINavigationController(rootViewController: FavoriteViewController())
        
        home.tabBarItem.image = UIImage(systemName: "house")
        search.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        favorite.tabBarItem.image = UIImage(systemName: "heart")
        
        home.title = "Home"
        search.title = "Search"
        favorite.title = "Favorites"
        
        tabBar.barTintColor = UIColorConstants.creamColor
        tabBar.tintColor = UIColorConstants.redColor
        tabBar.unselectedItemTintColor = UIColorConstants.lightRedColor
        
        setViewControllers([home, search, favorite], animated: true)
        
        
    }
}
