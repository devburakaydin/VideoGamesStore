//
//  HomeViewController.swift
//  VideoGamesStore
//
//  Created by Burak on 14.01.2023.
//

import UIKit

class HomeViewController: UIViewController {
    
    private let viewModel: HomeViewModel = HomeViewModel()
    
    public let videoGameCollectionView: UICollectionView = {
            let layout = UICollectionViewFlowLayout()
            layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 3 - 15, height: 200)
            layout.sectionInset = .init(top: 10, left: 10, bottom: 10, right: 10)
            layout.minimumInteritemSpacing = 0
            let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
            collectionView.backgroundColor = UIColorConstants.creamColor
            collectionView.register(VideoGameCollectionViewCell.self, forCellWithReuseIdentifier: VideoGameCollectionViewCell.identifier)
            return collectionView
        }()
    
    @objc func pressedFilter(){
        print("tıklandı")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(videoGameCollectionView)
        
        setupUI()
        viewModel.delegate = self
        videoGameCollectionView.delegate = self
        videoGameCollectionView.dataSource = self
        viewModel.didViewLoad()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        videoGameCollectionView.frame = view.bounds
    }
    
    func setupUI(){
        title = "Video Games Store"
        navigationController?.title = "Home"
        navigationController?.navigationBar.barTintColor = UIColorConstants.creamColor
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColorConstants.redColor!]
        view.backgroundColor = UIColorConstants.lightCreamColor
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "AToZIcon"),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(onTap)
        )
    }
    @objc private func onTap(){
        viewModel.changeFilter()
    }
    
}

extension HomeViewController: HomeViewModelDelegate {
    func changeFilter(isAToZ: Bool) {
        navigationItem.rightBarButtonItem?.image = isAToZ ? UIImage(named: "AToZIcon"): UIImage(named: "ZToAIcon")
    }
    
    func refreshVideoGames() {
        self.videoGameCollectionView.reloadData()
    }
}

extension HomeViewController: UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.videoGames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VideoGameCollectionViewCell.identifier, for: indexPath) as? VideoGameCollectionViewCell else { return UICollectionViewCell()}
        
        cell.configure(with: viewModel.videoGames[indexPath.item])
        
        return cell
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
            let ofsetY = scrollView.contentOffset.y
            let contentHeight = scrollView.contentSize.height
            let height = scrollView.frame.height
            
            if ofsetY >= contentHeight - (height*2) {
                viewModel.didViewLoad()
            }
        }
}
