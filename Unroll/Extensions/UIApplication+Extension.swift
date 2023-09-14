//
//  UIApplication+Extension.swift
//  Unroll
//
//  Created by Gabriel Garcia on 14/09/23.
//

import UIKit

extension UIApplication {
    
    static var safeAreaEdgeInsets: UIEdgeInsets  {
        
        let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        
        return scene?.windows.first?.safeAreaInsets ?? .zero
    }
}
