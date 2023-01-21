//
//  FavoriteViewController.swift
//  VideoGamesStore
//
//  Created by Burak on 14.01.2023.
//

import UIKit

class FavoriteViewController: UIViewController {
    
    public let favoriteTable: UICollectionView = {
            let layout = UICollectionViewFlowLayout()
            layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 3 - 15, height: 200)
            layout.sectionInset = .init(top: 10, left: 10, bottom: 10, right: 10)
            layout.minimumInteritemSpacing = 0
            let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
            collectionView.backgroundColor = UIColorConstants.creamColor
            collectionView.register(VideoGameCollectionViewCell.self, forCellWithReuseIdentifier: VideoGameCollectionViewCell.identifier)
            return collectionView
        }()
    
    private let viewModel: FavoriteViewModel = FavoriteViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColorConstants.creamColor
        title = "Favorites"
        view.addSubview(favoriteTable)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColorConstants.redColor!]
        viewModel.delegate = self
        favoriteTable.delegate = self
        favoriteTable.dataSource = self
        getFavorites()
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name("favorite"), object: nil, queue: nil) { _ in
            self.getFavorites()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        favoriteTable.frame = view.bounds
    }
    
    func getFavorites(){
        viewModel.getFavorites()
    }
    
    private func deleteFavorite(indexPath: IndexPath){
        viewModel.deleteFavorites(index: indexPath.item)
    }
}

extension FavoriteViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.favorites.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VideoGameCollectionViewCell.identifier, for: indexPath) as? VideoGameCollectionViewCell else { return UICollectionViewCell()}
        
        let item = viewModel.favorites[indexPath.item]
        
        let videoGame: VideoGame = VideoGame(id: Int(item.id), name: item.name, released: item.released, backgroundImage: item.backgroundImage, rating: item.rating, suggestionsCount: Int(item.suggestionsCount))
        cell.configure(with: videoGame)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        DispatchQueue.main.async {
            let vc = DetailViewController()
            
            let item = self.viewModel.favorites[indexPath.item]
            
            let videoGame: VideoGame = VideoGame(id: Int(item.id), name: item.name, released: item.released, backgroundImage: item.backgroundImage, rating: item.rating, suggestionsCount: Int(item.suggestionsCount))
            vc.configure(videoGame: videoGame)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        
        let config = UIContextMenuConfiguration(
                   identifier: nil,
                   previewProvider: nil) {[weak self] _ in
                       let downloadAction = UIAction(title: "Delete", subtitle: nil, image: nil, identifier: nil, discoverabilityTitle: nil, state: .off) { _ in
                           self?.deleteFavorite(indexPath: indexPath)
                       }
                       return UIMenu(title: "", image: nil, identifier: nil, options: .displayInline, children: [downloadAction])
                   }
               
               return config
    }
    
    
}
extension FavoriteViewController: FavoriteViewModelDelegate {
    func updateFavoriteList() {
        self.favoriteTable.reloadData()
    }
    
    
}
