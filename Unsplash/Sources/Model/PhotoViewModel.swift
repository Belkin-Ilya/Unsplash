//
//  ViewModel.swift
//  Unsplash
//
//  Created by Илья Белкин on 29.09.2022.
//

import Foundation

struct PhotoViewModel {
    let id: String?
    let likes: Int?
    var imageURL: String?
    var name: String?
    var createdAt: Date?
    var location: Location?
    var downloads: Int?
    var isFavorite: Bool = false
    
    init(model: Empty) {
        self.id = model.id
        self.likes = model.likes
        self.imageURL = model.urls.thumb
        self.name = model.user?.name
        self.createdAt = model.createdAt
        self.location = model.location
        self.downloads = model.downloads
    }
}
