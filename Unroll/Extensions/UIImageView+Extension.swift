//
//  UIImageView+Extension.swift
//  Unroll
//
//  Created by Gabriel Garcia on 12/09/23.
//

import UIKit

extension UIImageView {
    
    /// Loads an image from an url and returns its size
    /// - Parameters:
    ///   - url: image url
    ///   - returnImageSize: loaded image size
    func load(url: URL, returnImageSize: @escaping (CGSize) -> ()) {
        
        DispatchQueue.global().async { [weak self] in
            
            guard let data = try? Data(contentsOf: url), let image = UIImage(data: data) else {
                return
            }
            
            DispatchQueue.main.async {
                self?.image = image
                returnImageSize(image.size)
            }
        }
    }
}
