//
//  FavoritesTableViewCell.swift
//  Unsplash
//
//  Created by Илья Белкин on 30.09.2022.
//

import UIKit

class FavoritesTableViewCell: UITableViewCell {
    // MARK: - Public Properties
    
    static let id = "FavoritesTableViewCell"
    
    private lazy var thumbnail: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 15
        image.clipsToBounds = true
        return image
    }()
    
    private lazy var authorNamelabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "text"
        
        return label
    }()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupHierarchy()
        setConstraintsForFavoriteImage()
        setConstraintsForLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with viewModel: PhotoViewModel) {
        thumbnail.setImage(from: viewModel.imageURL)
        authorNamelabel.text = viewModel.name
    }
    
    private func setupHierarchy() {
        addSubview(thumbnail)
        addSubview(authorNamelabel)
    }
    
    private func setConstraintsForFavoriteImage() {
        NSLayoutConstraint.activate([
            thumbnail.centerYAnchor.constraint(equalTo: centerYAnchor),
            thumbnail.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            thumbnail.heightAnchor.constraint(equalToConstant: 30),
            thumbnail.widthAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    private func setConstraintsForLabel() {
        NSLayoutConstraint.activate([
            authorNamelabel.centerYAnchor.constraint(equalTo: thumbnail.centerYAnchor),
            authorNamelabel.leadingAnchor.constraint(equalTo: thumbnail.trailingAnchor, constant: 15),
        ])
    }
}
