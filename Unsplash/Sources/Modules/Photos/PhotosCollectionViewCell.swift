//
//  PhotosCollectionViewCell.swift
//  Unsplash
//
//  Created by Илья Белкин on 29.09.2022.
//

import UIKit

final class PhotosCollectionViewCell: UICollectionViewCell {
    // MARK: - Public Properties
    
    static let id = "PhotoCollectionViewCell"
    
    lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with viewModel: PhotoViewModel) {
        imageView.setImage(from: viewModel.imageURL)
    }
    
    // MARK: - Private Methods
    
    private func addSubViews() {
        addSubview(imageView)
        activateImageViewConstraints()
    }
    
    private func activateImageViewConstraints() {
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            imageView.topAnchor.constraint(equalTo: topAnchor)
        ])
    }
}
