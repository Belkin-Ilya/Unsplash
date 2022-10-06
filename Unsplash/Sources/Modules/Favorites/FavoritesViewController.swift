//
//  ViewController.swift
//  Unsplash
//
//  Created by Илья Белкин on 29.09.2022.
//

import UIKit

final class FavoritesViewController: UIViewController {
    // MARK: - Public Properties
    
    var favoriteViewModels: [PhotoViewModel] = []
    
    // MARK: - Lifecycle
    
    override func loadView() {
        super.loadView()
        let favoritesView = FavoritesView()
        favoritesView.delegate = self
        self.view = favoritesView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        favoriteViewModels = Repository.shared.getFavoriteViewModels()
        guard let favoritesView = self.view as? FavoritesView else { return }
        favoritesView.tableView.reloadData()
    }
    
    // MARK: - Private Methods
    
    private func configureNavigationBar() {
        view.backgroundColor = .white
        title = "Favorites"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func removeFavoritesPhotos(with viewModel: PhotoViewModel) {
        guard let index = Repository.shared.viewModels.firstIndex(where: { $0.id == viewModel.id }) else { return }
        Repository.shared.viewModels[index].isFavorite = false
    }
}

// MARK: - FavoritesViewDelegate

extension FavoritesViewController: FavoritesViewDelegate {
    func favoritesViewGetViewModelsCount(_ favoritesView: FavoritesView) -> Int? {
        return favoriteViewModels.count
    }
    
    func favoritesViewGetPhotoModel(_ favoritesView: FavoritesView, getPhotoViewModelAt index: Int) -> PhotoViewModel? {
        return favoriteViewModels[index]
    }
    
    func favoritesPhotosView(_ favoritesPhotosView: FavoritesView, didselectPhotoAtIndex index: Int) {
        let controller = DetailViewController()
        controller.viewModel = favoriteViewModels[index]
        navigationController?.pushViewController(controller, animated: true)
        
    }
    
    func favoritesEditingPhotosView(_ favoritesPhotosView: FavoritesView, editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let model = favoriteViewModels[indexPath.row]
            removeFavoritesPhotos(with: model)
            favoriteViewModels.remove(at: indexPath.row)
            favoritesPhotosView.tableView.reloadData()
            presentSearchAlertController(withTitle: "Notification", message: "Favorite photo deleted", style: .alert)
        }
    }
}
extension FavoritesViewController {
    func presentSearchAlertController (withTitle title: String?, message: String?, style: UIAlertController.Style) {
        let alertContoller = UIAlertController(title: title, message: message, preferredStyle: style)
        let cancel = UIAlertAction(title: "To close", style: .cancel, handler: nil)
        alertContoller.addAction(cancel)
        present(alertContoller, animated: true, completion: nil)
    }
}
