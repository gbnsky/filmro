//
//  UIImageView+Extension.swift
//  Unroll
//
//  Created by Gabriel Garcia on 12/09/23.
//

import UIKit

// load an image with urls

extension UIImageView {
    
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
