//
//  UIView+Extension.swift
//  Unroll
//
//  Created by Gabriel Garcia on 14/09/23.
//

import UIKit

/// Adds a border to a specific side of the view
/// - Parameters:
///   - color: border color
///   - width: border width
extension UIView {
    
  func addTopBorder(_ color: UIColor, _ width: CGFloat) {
      let border = CALayer()
      border.backgroundColor = color.cgColor
      border.frame = CGRectMake(.zero, .zero, self.frame.size.width, width)
      self.layer.addSublayer(border)
  }

  func addRightBorder(_ color: UIColor, _ width: CGFloat) {
      let border = CALayer()
      border.backgroundColor = color.cgColor
      border.frame = CGRectMake(self.frame.size.width - width, .zero, width, self.frame.size.height)
      self.layer.addSublayer(border)
  }

  func addBottomBorder(_ color: UIColor, _ width: CGFloat) {
      let border = CALayer()
      border.backgroundColor = color.cgColor
      border.frame = CGRectMake(.zero, self.frame.size.height - width, self.frame.size.width, width)
      self.layer.addSublayer(border)
  }

  func addLeftBorder(_ color: UIColor, _ width: CGFloat) {
      let border = CALayer()
      border.backgroundColor = color.cgColor
      border.frame = CGRectMake(.zero, .zero, width, self.frame.size.height)
      self.layer.addSublayer(border)
  }
}
