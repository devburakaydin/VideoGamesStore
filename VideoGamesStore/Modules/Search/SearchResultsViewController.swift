//
//  SearchResultsViewController.swift
//  VideoGamesStore
//
//  Created by Burak on 17.01.2023.
//

import UIKit

protocol SearchResultsViewControllerDelegate: AnyObject {
    func didSelectVideoGame(videoGame: VideoGame)
}


class SearchResultsViewController: UIViewController {
    
    var videoGamesResult: [VideoGame] = []
    
    weak var delegate: SearchResultsViewControllerDelegate?
    
    public let searchCollectionView: UICollectionView = {
            let layout = UICollectionViewFlowLayout()
            layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 3 - 15, height: 200)
            layout.sectionInset = .init(top: 10, left: 10, bottom: 10, right: 10)
            layout.minimumInteritemSpacing = 0
            let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
            collectionView.backgroundColor = UIColorConstants.creamColor
            collectionView.register(VideoGameCollectionViewCell.self, forCellWithReuseIdentifier: VideoGameCollectionViewCell.identifier)
            return collectionView
        }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(searchCollectionView)
        
        searchCollectionView.delegate = self
        searchCollectionView.dataSource = self
        
        navigationItem.rightBarButtonItem?.tintColor = UIColorConstants.redColor
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        searchCollectionView.frame = view.bounds
    }
}

extension SearchResultsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        videoGamesResult.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VideoGameCollectionViewCell.identifier, for: indexPath) as? VideoGameCollectionViewCell else { return UICollectionViewCell()}
        
        cell.configure(with: videoGamesResult[indexPath.item])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.didSelectVideoGame(videoGame: videoGamesResult[indexPath.item])
    }
    
    
}
