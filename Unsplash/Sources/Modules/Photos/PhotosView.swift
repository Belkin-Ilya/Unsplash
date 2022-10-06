//
//  PhotosView.swift
//  Unsplash
//
//  Created by Илья Белкин on 29.09.2022.
//

import UIKit

protocol PhotoCollectionViewDelegate: AnyObject {
    func photosViewGetViewModelsCount(_ photosView: PhotosView) -> Int?
    func photosViewGetPhotoModel(_ photosView: PhotosView, getPhotoViewModelAt index: Int) -> PhotoViewModel?
    func photosView(_ photosView: PhotosView, didselectPhotoAtIndex index: Int)
}

final class PhotosView: UIView {
    // MARK: - Public Properties
    
    weak var customDelegate: PhotoCollectionViewDelegate?
    
    private func makeCollectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        return layout
    }

     lazy var collectionView: UICollectionView = {
        let layout = makeCollectionViewLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: PhotosCollectionViewCell.id)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
     lazy var loader: UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView()
        loader.translatesAutoresizingMaskIntoConstraints = false
        return loader
    }()
    
    // MARK: - Init
    
    init() {
        super.init(frame: .zero)
        configureView()
        setupHierarchy()
        activateCollectionViewConstraints()
        setLoader()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func configureView() {
        backgroundColor = .white
    }
    
    private func setupHierarchy() {
        addSubview(collectionView)
        addSubview(loader)
    }
    
    private func activateCollectionViewConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func setLoader() {
        NSLayoutConstraint.activate([
            loader.centerXAnchor.constraint(equalTo: centerXAnchor),
            loader.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}

// MARK: - UICollectionViewDataSource

extension PhotosView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return customDelegate?.photosViewGetViewModelsCount(self) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellID = PhotosCollectionViewCell.id
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as? PhotosCollectionViewCell,
            let viewModel = customDelegate?.photosViewGetPhotoModel(self, getPhotoViewModelAt: indexPath.row)
        else {
            return UICollectionViewCell()
        }
        
        cell.configure(with: viewModel)
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension PhotosView: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(
            width:  (collectionView.frame.size.width / 2.12) - 5,
            height: (collectionView.frame.size.height / 4) - 5
        )
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        customDelegate?.photosView(self, didselectPhotoAtIndex: indexPath.row)
    }
}
