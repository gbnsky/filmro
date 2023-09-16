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

extension UIImageView {
    
    /// Constraint multiplier ratio for full height images with scale aspect fit content mode
    /// - Returns: Full height multiplier ratio
    func fullHeightRatio() -> CGFloat {
        
        let viewSize = self.intrinsicContentSize
        
        if let image = self.image {
            return viewSize.width / image.size.height
        }
        
        return viewSize.width / viewSize.height
    }
    
    /// Constraint multiplier ratio for full height images with scale aspect fit content mode
    /// - Returns: Full width multiplier ratio
    func fullWidthRatio() -> CGFloat {
        
        let viewSize = self.intrinsicContentSize
        
        if let image = self.image {
            return viewSize.height / image.size.width
        }
        
        return viewSize.height / viewSize.width
    }
}
