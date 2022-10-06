//
//  PhotosViewController.swift
//  Unsplash
//
//  Created by Илья Белкин on 29.09.2022.
//

import UIKit

final class PhotosViewController: UIViewController {
    // MARK: - Private Properties
    
    private lazy var searchСontroller = UISearchController()
    private var viewModels: [PhotoViewModel] = []
    
    private var photoCollectionView: PhotosView? {
        guard isViewLoaded else { return nil }
        return view as? PhotosView
    }
    
    // MARK: - Lifecycle
    
    override func loadView() {
        super.loadView()
        let view = PhotosView()
        view.customDelegate = self
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureSearchController()
        fetchData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModels = Repository.shared.viewModels
    }
    
    // MARK: - Private Methods
    
    private func fetchData() {
        self.photoCollectionView?.loader.startAnimating()
        Repository.shared.getModels { [weak self] viewModels in
            guard let self = self else { return }
            self.viewModels = viewModels
            DispatchQueue.main.async {
                self.photoCollectionView?.collectionView.reloadData()
                self.photoCollectionView?.loader.stopAnimating()
            }
        }
    }
    
    private func configureNavigationBar() {
        title = "Photos"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    // MARK: - Layout
    
    private func configureSearchController() {
        searchСontroller.searchBar.placeholder = "Search"
        searchСontroller.automaticallyShowsCancelButton = true
        searchСontroller.searchBar.setImage(UIImage(systemName: "magnifyingglass"), for: .search, state: .normal)
        navigationItem.searchController = searchСontroller
    }
}

// MARK: - PhotoCollectionViewDelegate

extension PhotosViewController: PhotoCollectionViewDelegate {
    func photosViewGetViewModelsCount(_ photosView: PhotosView) -> Int? {
        return viewModels.count
    }
    
    func photosViewGetPhotoModel(_ photosView: PhotosView, getPhotoViewModelAt index: Int) -> PhotoViewModel? {
        return viewModels[index]
    }
    
    func photosView(_ photosView: PhotosView, didselectPhotoAtIndex index: Int) {
        let controller = DetailViewController()
        controller.viewModel = viewModels[index]
        navigationController?.pushViewController(controller, animated: true)
    }
}

