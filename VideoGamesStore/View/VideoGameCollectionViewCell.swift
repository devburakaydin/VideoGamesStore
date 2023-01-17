//
//  VideoGameCollectionViewCell.swift
//  VideoGamesStore
//
//  Created by Burak on 16.01.2023.
//

import UIKit
import Kingfisher

class VideoGameCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "VideoGameCollectionViewCell"
    
    private let posterUIImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Deneme"
        label.numberOfLines = 0
        label.textColor = UIColorConstants.redColor
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColorConstants.lightCreamColor
        layer.cornerRadius = 10
        clipsToBounds = true
        contentView.addSubview(posterUIImageView)
        contentView.addSubview(titleLabel)
        applyConstraints()
    }
    
    override func prepareForReuse() {
            super.prepareForReuse()
            posterUIImageView.image = nil
            posterUIImageView.kf.cancelDownloadTask()
            
        }
    
    private func applyConstraints(){
        
        let posterUIImageViewConstraints = [
            posterUIImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            posterUIImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            posterUIImageView.topAnchor.constraint(equalTo: topAnchor),
            posterUIImageView.heightAnchor.constraint(equalToConstant: 130)
        ]
        
        let titleLabelConstraints = [
            titleLabel.topAnchor.constraint(equalTo: posterUIImageView.bottomAnchor, constant: 5),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
        ]
        
        NSLayoutConstraint.activate(titleLabelConstraints)
        NSLayoutConstraint.activate(posterUIImageViewConstraints)
    }
    
    public func configure(with model: VideoGame) {
        guard let url = URL(string: "\(model.backgroundImage!)") else {return}
        titleLabel.text = model.name ?? ""
        posterUIImageView.kf.setImage(with: url)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
