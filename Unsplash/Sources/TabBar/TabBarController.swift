//
//  TabBarController.swift
//  Unsplash
//
//  Created by Илья Белкин on 29.09.2022.
//

import UIKit

final class TabBarController: UITabBarController, UITabBarControllerDelegate {
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        setupBar()
    }
    
    // MARK: - Private Methods
    
    private func setupBar() {
        let photos = createNavigationContoller(viewContoller: PhotosViewController(), itemName: "Photos", itemImage: "photo", selectedImage: "photo.fill")
        let favorites = createNavigationContoller(viewContoller: FavoritesViewController(), itemName: "Favorites", itemImage: "heart", selectedImage: "heart.fill")
        viewControllers = [photos, favorites]
    }
    
    private func createNavigationContoller(viewContoller: UIViewController, itemName: String, itemImage: String, selectedImage: String) -> UINavigationController {
        let item = UITabBarItem(title: itemName, image: UIImage(systemName: itemImage), selectedImage: UIImage(systemName: selectedImage))
        let navigationContoller = UINavigationController(rootViewController: viewContoller)
        navigationContoller.tabBarItem = item
        return navigationContoller
    }
    
}
