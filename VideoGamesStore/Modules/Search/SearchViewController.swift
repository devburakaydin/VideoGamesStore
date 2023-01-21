//
//  SearchViewController.swift
//  VideoGamesStore
//
//  Created by Burak on 17.01.2023.
//

import UIKit

class SearchViewController: UIViewController {
    
    private let searchController: UISearchController = {
        let controller = UISearchController(searchResultsController: SearchResultsViewController())
        controller.searchBar.placeholder = LocalizationHelper.searchForAVideoGames.localized
        controller.searchBar.searchBarStyle = .minimal
        return controller
    }()
    
    private let viewModel: SearchViewModel = SearchViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel.delegate = self
    }

    func setupUI(){
        title = LocalizationHelper.search.localized
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColorConstants.redColor!]
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
    }
}

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        
        guard let query = searchBar.text,
              !query.trimmingCharacters(in: .whitespaces).isEmpty,
              query.trimmingCharacters(in: .whitespaces).count >= 3
        else { return }
        
        viewModel.search(query: query)
    }
}

extension SearchViewController: SearchViewModelDelegate {
    func refreshSearch() {
        guard let resultsController = searchController.searchResultsController as? SearchResultsViewController else { return }
        resultsController.delegate = self
        resultsController.videoGamesResult = viewModel.videoGamesResult
        resultsController.searchCollectionView.reloadData()
    }
}

extension SearchViewController: SearchResultsViewControllerDelegate {
    func didSelectVideoGame(videoGame: VideoGame) {
        DispatchQueue.main.async {
            let vc = DetailViewController()
            vc.configure(videoGame: videoGame)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
}
