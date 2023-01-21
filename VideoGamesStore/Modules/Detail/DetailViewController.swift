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
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel: UILabel = {
       let label = UILabel()
        label.text = "Deneme"
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
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    
    private let viewModel: DetailViewModel = DetailViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel.delegate = self
        view.addSubview(gameImageView)
        view.addSubview(ratingLabel)
        view.addSubview(titleLabel)
        view.addSubview(ratingIcon)
        view.addSubview(releasedLabel)
        view.addSubview(sugLabel)
        view.addSubview(notesButton)
        notesButton.addTarget(self, action: #selector(addNote), for: .touchDown)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "heart"),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(didSelectFavoriteIcon))
        navigationItem.rightBarButtonItem?.tintColor = .red
        
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
    }
    
    private func applyConstraints(){
        let gameImageViewContraints = [
            gameImageView.topAnchor.constraint(equalTo: view.topAnchor),
            gameImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            gameImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            gameImageView.heightAnchor.constraint(equalToConstant: 400)
        ]
        NSLayoutConstraint.activate(gameImageViewContraints)
        
        let ratingLabelContraints = [
            ratingLabel.topAnchor.constraint(equalTo: gameImageView.bottomAnchor, constant: 20),
            ratingLabel.widthAnchor.constraint(equalToConstant: 40),
            ratingLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ]
        NSLayoutConstraint.activate(ratingLabelContraints)

        let ratingIconContraints = [
            ratingIcon.topAnchor.constraint(equalTo: gameImageView.bottomAnchor, constant: 15),
            ratingIcon.trailingAnchor.constraint(equalTo: ratingLabel.leadingAnchor,constant: -5),
            ratingIcon.heightAnchor.constraint(equalToConstant: 30),
            ratingIcon.widthAnchor.constraint(equalToConstant: 30),
        ]
        NSLayoutConstraint.activate(ratingIconContraints)

        let titleLabelContraints = [
            titleLabel.topAnchor.constraint(equalTo: gameImageView.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: ratingIcon.trailingAnchor, constant: -20),
        ]
        NSLayoutConstraint.activate(titleLabelContraints)
        
        let releasedLabelContraints = [
            releasedLabel.topAnchor.constraint(equalTo: ratingIcon.bottomAnchor, constant: 20),
            releasedLabel.widthAnchor.constraint(equalToConstant: 200),
            releasedLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ]
        NSLayoutConstraint.activate(releasedLabelContraints)
        
        let sugLabelContraints = [
            sugLabel.topAnchor.constraint(equalTo: ratingIcon.bottomAnchor, constant: 20),
            sugLabel.trailingAnchor.constraint(equalTo: releasedLabel.leadingAnchor, constant: -20),
            sugLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        ]
        NSLayoutConstraint.activate(sugLabelContraints)
        
        let notesButtonContraints = [
            notesButton.topAnchor.constraint(equalTo: releasedLabel.bottomAnchor, constant: 50),
            notesButton.widthAnchor.constraint(equalToConstant: 100),
            notesButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ]
        NSLayoutConstraint.activate(notesButtonContraints)
    }
    
    func configure(videoGame: VideoGame) {
        self.viewModel.videoGame = videoGame
        titleLabel.text = videoGame.name ?? "Empty Data"
        ratingLabel.text = String(videoGame.rating ?? 0.0)
        releasedLabel.text = "Released \(videoGame.released ?? "Empty Data")"
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
