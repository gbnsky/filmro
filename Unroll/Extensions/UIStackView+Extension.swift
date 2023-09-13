//
//  UIStackView+Extension.swift
//  Unroll
//
//  Created by Gabriel Garcia on 13/09/23.
//

import UIKit

// add arranged subview with margins

extension UIStackView {
    
    func addArrangedSubview(_ view: UIView, withMargins margins: UIEdgeInsets) {
        
        let container = UIView()
        container.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: container.topAnchor, constant: margins.top),
            view.rightAnchor.constraint(equalTo: container.rightAnchor, constant: margins.right),
            view.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: margins.bottom),
            view.leftAnchor.constraint(equalTo: container.leftAnchor, constant: margins.left)
        ])
        
        addArrangedSubview(container)
    }
}
