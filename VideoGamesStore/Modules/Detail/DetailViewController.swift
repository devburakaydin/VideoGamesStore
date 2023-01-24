//
//  DetailViewController.swift
//  VideoGamesStore
//
//  Created by Burak on 17.01.2023.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController {
    
    private let gameImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .blue
        imageView.layer.cornerRadius = 15
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel: UILabel = {
       let label = UILabel()
        label.text = "Deneme"
        label.font = .boldSystemFont(ofSize: 25)
        label.numberOfLines = 0
        label.textColor = UIColorConstants.redColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let releasedLabel: UILabel = {
       let label = UILabel()
        label.text = "Deneme"
        label.textColor = UIColorConstants.lightRedColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let ratingIcon: UIImageView = {
       let image = UIImageView(image: UIImage(named: "star"))
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let ratingLabel: UILabel = {
       let label = UILabel()
        label.text = "Deneme"
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = UIColorConstants.redColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let sugLabel: UILabel = {
       let label = UILabel()
        label.text = "Deneme"
        label.textColor = UIColorConstants.lightRedColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let notesButton: UIButton = {
        let button = UIButton()
        button.setTitle(LocalizationHelper.notes.localized, for: .normal)
        button.layer.borderColor = UIColor.white.cgColor
        button.backgroundColor = UIColorConstants.redColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    
    private let viewModel: DetailViewModel = DetailViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel.delegate = self
        view.addSubview(gameImageView)
        gameImageView.addSubview(ratingLabel)
        gameImageView.addSubview(titleLabel)
        gameImageView.addSubview(ratingIcon)
        view.addSubview(releasedLabel)
        view.addSubview(sugLabel)
        view.addSubview(notesButton)
        notesButton.addTarget(self, action: #selector(addNote), for: .touchDown)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "heart"),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(didSelectFavoriteIcon))
        
        navigationItem.rightBarButtonItem?.tintColor = UIColorConstants.redColor
        navigationItem.backBarButtonItem?.tintColor = UIColorConstants.redColor
        navigationController?.tabBarItem.badgeColor = .red
        navigationItem.backButtonTitle = "AAAa"
        
        applyConstraints()
        viewModel.favoriteControl()

    }
    
    @objc func addNote(){
        let vc = EditNoteViewController()
        vc.configure(gameId: viewModel.videoGame?.id ?? 0)
        self.present(vc, animated: true)
    }
    
    @objc func didSelectFavoriteIcon(){
        viewModel.onTapFavorite()
        
    }
    
    func setupUI(){
        view.backgroundColor = UIColorConstants.creamColor
        navigationItem.leftBarButtonItem?.tintColor = UIColorConstants.redColor
    }
    
    private func applyConstraints(){
        let gameImageViewContraints = [
            gameImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            gameImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            gameImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
            gameImageView.heightAnchor.constraint(equalToConstant: view.safeAreaLayoutGuide.layoutFrame.height/2)
        ]
        NSLayoutConstraint.activate(gameImageViewContraints)
        
        let ratingLabelContraints = [
            ratingLabel.topAnchor.constraint(equalTo: gameImageView.topAnchor, constant: 20),
            ratingLabel.trailingAnchor.constraint(equalTo: gameImageView.trailingAnchor, constant: -20),
        ]
        NSLayoutConstraint.activate(ratingLabelContraints)

        let ratingIconContraints = [
            ratingIcon.topAnchor.constraint(equalTo: gameImageView.topAnchor, constant: 15),
            ratingIcon.trailingAnchor.constraint(equalTo: ratingLabel.leadingAnchor,constant: -5),
            ratingIcon.heightAnchor.constraint(equalToConstant: 30),
            ratingIcon.widthAnchor.constraint(equalToConstant: 30),
        ]
        NSLayoutConstraint.activate(ratingIconContraints)

        let titleLabelContraints = [
            titleLabel.bottomAnchor.constraint(equalTo: gameImageView.bottomAnchor, constant: -20),
            titleLabel.leadingAnchor.constraint(equalTo: gameImageView.leadingAnchor,constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: gameImageView.trailingAnchor, constant: -20),
        ]
        NSLayoutConstraint.activate(titleLabelContraints)

        let releasedLabelContraints = [
            releasedLabel.topAnchor.constraint(equalTo: gameImageView.bottomAnchor, constant: 20),
            releasedLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
        ]
        NSLayoutConstraint.activate(releasedLabelContraints)

        let sugLabelContraints = [
            sugLabel.topAnchor.constraint(equalTo: releasedLabel.bottomAnchor, constant: 20),
            sugLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
        ]
        NSLayoutConstraint.activate(sugLabelContraints)

        let notesButtonContraints = [
            notesButton.topAnchor.constraint(equalTo: sugLabel.bottomAnchor, constant: 50),
            notesButton.widthAnchor.constraint(equalToConstant: 100),
            notesButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ]
        NSLayoutConstraint.activate(notesButtonContraints)
    }
    
    func configure(videoGame: VideoGame) {
        self.viewModel.videoGame = videoGame
        titleLabel.text = videoGame.name ?? "Empty Data"
        ratingLabel.text = String(videoGame.rating ?? 0.0)
        releasedLabel.text = "Released: \(videoGame.released ?? "Empty Data")"
        sugLabel.text = "Suggestions: \(videoGame.suggestionsCount ?? 0)"
        
        guard let url = videoGame.backgroundImage else { return }
        gameImageView.kf.setImage(with: URL(string: url))
    }

}

extension DetailViewController: DetailViewModelDelegate {
    func updateFavoriteIcon() {
        if viewModel.favoriteItem == nil {
            navigationItem.rightBarButtonItem?.image = UIImage(named: "heart")
        }else{
            navigationItem.rightBarButtonItem?.image = UIImage(named: "heart.fill")
        }
    }
    
    
}
