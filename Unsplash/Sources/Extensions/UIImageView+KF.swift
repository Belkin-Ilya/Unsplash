//
//  UIImageView+KF.swift
//  Unsplash
//
//  Created by Илья Белкин on 30.09.2022.
//

import UIKit
import Kingfisher

extension UIImageView {
    public func setImage(from urlString: String?,
                         placeholder: UIImage? = nil,
                         processor: ImageProcessor? = nil,
                         completionHandler: ((Result<RetrieveImageResult, KingfisherError>) -> Void)? = nil) {
        var options: KingfisherOptionsInfo = [.transition(.fade(0.2))]
        if let item = processor {
            options.append(.processor(item))
        }
        
        if let urlString = urlString, let url = URL(string: urlString) {
            self.kf.setImage(with: url,
                             placeholder: placeholder,
                             options: options,
                             completionHandler: completionHandler)
        }
    }
}

