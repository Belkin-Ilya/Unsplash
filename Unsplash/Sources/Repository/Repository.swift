//
//  Repository.swift
//  Unsplash
//
//  Created by Илья Белкин on 02.10.2022.
//

import Foundation

class Repository {
    // MARK: - Public Properties
    
    static let shared = Repository()
    var viewModels: [PhotoViewModel] = []
    
    // MARK: - Init
    
    private init() {}
    
    // MARK: - Public Methods
    
    func update(with viewModel: PhotoViewModel?) {
        guard let viewModel = viewModel,
              let index = viewModels.firstIndex(where: { $0.id == viewModel.id }) else {
            return
        }
        
        viewModels[index] = viewModel
    }
    
    func getFavoriteViewModels() -> [PhotoViewModel] {
        return Mapper.getFavoriteViewModels(of: self.viewModels)
    }
    
    func getModels(completion: (([PhotoViewModel]) -> Void)?) {
        NetworkManager.shared.fetchData(of: [Empty].self) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                self.viewModels = data.map ({ PhotoViewModel(model: $0)})
            case .failure(let error):
                print(error.localizedDescription)
            }
            
            completion?(self.viewModels)
        }
    }
}
