//
//  FavoritesView.swift
//  Unsplash
//
//  Created by Илья Белкин on 30.09.2022.
//

import UIKit

protocol FavoritesViewDelegate: AnyObject {
    func favoritesViewGetViewModelsCount(_ favoritesView: FavoritesView) -> Int?
    func favoritesViewGetPhotoModel(_ favoritesView: FavoritesView, getPhotoViewModelAt index: Int) -> PhotoViewModel?
    func favoritesPhotosView(_ favoritesPhotosView: FavoritesView, didselectPhotoAtIndex index: Int)
    func favoritesEditingPhotosView(_ favoritesPhotosView: FavoritesView, editingStyle: UITableViewCell.EditingStyle, forRowAt index: IndexPath)
}

final class FavoritesView: UIView {
    // MARK: - Public Properties
    
    weak var delegate: FavoritesViewDelegate?
    
    // MARK: - Private Properties
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(FavoritesTableViewCell.self, forCellReuseIdentifier: FavoritesTableViewCell.id)
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    // MARK: - Init
    
    init() {
        super.init(frame: .zero)
        setupHierarchy()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func setupHierarchy() {
        addSubview(tableView)
        setConstraintsForTableView()
    }
    
    // MARK: - Layout
    
    private func setConstraintsForTableView() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

// MARK: - UITableViewDataSource

extension FavoritesView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return delegate?.favoritesViewGetViewModelsCount(self) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavoritesTableViewCell.id,
                                                       for: indexPath) as? FavoritesTableViewCell,
              let viewModel = delegate?.favoritesViewGetPhotoModel(self, getPhotoViewModelAt: indexPath.row)
        else { return UITableViewCell() }
        
        cell.configure(with: viewModel)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.favoritesPhotosView(self, didselectPhotoAtIndex: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        delegate?.favoritesEditingPhotosView(self, editingStyle: editingStyle, forRowAt: indexPath)
    }
    
}
