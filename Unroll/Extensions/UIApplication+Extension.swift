//
//  UIApplication+Extension.swift
//  Unroll
//
//  Created by Gabriel Garcia on 14/09/23.
//

import UIKit

/// Access the first scene window and returns the safe area insets
/// - Parameters:
///   - return: safe area insets
extension UIApplication {
    
    static var safeAreaEdgeInsets: UIEdgeInsets  {
        
        let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        
        return scene?.windows.first?.safeAreaInsets ?? .zero
    }
}
