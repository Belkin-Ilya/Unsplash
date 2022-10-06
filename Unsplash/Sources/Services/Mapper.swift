//
//  Mapper.swift
//  Unsplash
//
//  Created by Илья Белкин on 29.09.2022.
//

import Foundation

class Mapper {
    static func getFavoriteViewModels(of viewModels: [PhotoViewModel]) -> [PhotoViewModel] {
        return viewModels.filter { $0.isFavorite }
    }
    
    private init() {}
}
