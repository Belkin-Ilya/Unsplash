//
//  DetailViewController.swift
//  Unsplash
//
//  Created by Илья Белкин on 30.09.2022.
//

import UIKit

final class DetailViewController: UIViewController {
    // MARK: - Public Properties
    
    var viewModel: PhotoViewModel?
    
    weak var customDelegate: DetailViewDelegate?
    
    // MARK: - Private Properties
    
    private var detailView: DetailView? {
        guard isViewLoaded else { return nil }
        return view as? DetailView
    }
    
    private lazy var backButton: UIBarButtonItem = {
        let backButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backAction(sender:)))
        return backButton
    }()
    
    // MARK: - Lifecycle
    
    override func loadView() {
        super.loadView()
        let view = DetailView()
        view.delegate = self
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Detail"
        navigationItem.setLeftBarButton(backButton, animated: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let viewModel = viewModel else {
            return
        }
        configure(with: viewModel)
        updateViewModel()
    }
    
    // MARK: - Public Methods
    
    func configure(with viewModel: PhotoViewModel) {
        guard let detailView = self.view as? DetailView else { return }
        detailView.configure(with: viewModel)
    }
    
    private func updateViewModel() {
        guard let viewModel = self.viewModel,
                let index = Repository.shared.viewModels.firstIndex(where: { $0.id == viewModel.id }) else { return }
        self.viewModel?.isFavorite = Repository.shared.viewModels[index].isFavorite
        detailView?.update(viewModel: self.viewModel)
    }
    
    // MARK: - Private Methods
    
    @objc private func backAction(sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - DetailViewDelegate

extension DetailViewController: DetailViewDelegate {    
    func detailViewUpdateViewModel(_ detailView: DetailView) {
        viewModel?.isFavorite.toggle()
        detailView.update(viewModel: viewModel)
        Repository.shared.update(with: viewModel)
    }
}


// hide tabbar
// reload button
