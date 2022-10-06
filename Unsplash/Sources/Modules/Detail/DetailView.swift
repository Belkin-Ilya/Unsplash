//
//  DetailView.swift
//  Unsplash
//
//  Created by Илья Белкин on 30.09.2022.
//

import UIKit

protocol DetailViewDelegate: AnyObject {
    func detailViewUpdateViewModel(_ detailView: DetailView)
}

final class DetailView: UIView {
    // MARK: - Public Properties
    
    weak var delegate: DetailViewDelegate?
    
    // MARK: - Private Properties
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 10.0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var detailImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var authorNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var createDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var locationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var countDonwloadsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var favoriteButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didTapFavoriteButton), for: .touchUpInside)
        button.setImage(UIImage(systemName: "suit.heart.fill"), for: .normal)
        return button
    }()
    
    // MARK: - Init
    
    init() {
        super.init(frame: .zero)
        setupHierarchy()
        setConstraintsForDetailImage()
        setConstraintsForStackView()
        setConstraintsForButton()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    func update(viewModel: PhotoViewModel?) {
        if let viewModel = viewModel, viewModel.isFavorite {
            favoriteButton.tintColor = .red
        } else {
            favoriteButton.tintColor = .white
        }
    }
    
    func configure(with viewModel: PhotoViewModel) {
        let date = Date()
        let format = date.getFormattedDate(format: "yyyy-MM-dd HH:mm:ss") // Set output format
        
        detailImage.setImage(from: viewModel.imageURL)
        authorNameLabel.text = viewModel.name
        createDateLabel.text = viewModel.createdAt?.getFormattedDate(format: format) 
        locationLabel.text = viewModel.location?.city ?? ""
        countDonwloadsLabel.text = "\(viewModel.downloads ?? 0)"
        update(viewModel: viewModel)
    }
    
    // MARK: - Private Methods
    
    private func configureView() {
        backgroundColor = .white
    }
    
    private func setupHierarchy() {
        addSubview(stackView)
        addSubview(detailImage)
        addSubview(favoriteButton)
        stackView.addArrangedSubview(authorNameLabel)
        stackView.addArrangedSubview(countDonwloadsLabel)
        stackView.addArrangedSubview(locationLabel)
        stackView.addArrangedSubview(createDateLabel)
    }
    
    // MARK: - Actions
    
    @objc private func didTapFavoriteButton()  {
        delegate?.detailViewUpdateViewModel(self)
    }
    
    // MARK: - Layout
    
    private func setConstraintsForDetailImage() {
        NSLayoutConstraint.activate([
            detailImage.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            detailImage.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5),
            detailImage.widthAnchor.constraint(equalTo: widthAnchor),
            detailImage.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    private func setConstraintsForStackView() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: detailImage.bottomAnchor, constant: 8),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -3)
        ])
    }
    
    private func setConstraintsForButton() {
        NSLayoutConstraint.activate([
            favoriteButton.bottomAnchor.constraint(equalTo: detailImage.bottomAnchor, constant: -16),
            favoriteButton.trailingAnchor.constraint(equalTo: detailImage.trailingAnchor, constant: -16),
            favoriteButton.heightAnchor.constraint(equalToConstant: 25),
            favoriteButton.widthAnchor.constraint(equalToConstant: 25)
        ])
    }
}


