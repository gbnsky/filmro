//
//  RuntimeView.swift
//  Unroll
//
//  Created by Gabriel Garcia on 13/09/23.
//

import UIKit

class RuntimeView: UIView {
    
    // MARK: - UI Components
    
    private lazy var title: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Colors.blackOne
        label.font = UIFont(name: Fonts.breeSerif, size: 16)
        label.numberOfLines = 3
        label.lineBreakMode = .byTruncatingTail
        label.text = "Runtime"
        return label
    }()
    
    private lazy var slider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.minimumValue = 0
        slider.maximumValue = 180
        slider.isContinuous = true
        slider.tintColor = Colors.orange
        return slider
    }()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - View Coding

extension RuntimeView {
    
    private func loadView() {
        addSubviews()
        addConstraints()
    }
    
    private func addSubviews() {
        addSubview(title)
        addSubview(slider)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            
            // title
            
            title.topAnchor.constraint(equalTo: topAnchor),
            title.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            title.heightAnchor.constraint(equalToConstant: 48),
            
            // slider
            
            slider.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 16),
            slider.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            slider.bottomAnchor.constraint(equalTo: bottomAnchor),
            slider.leftAnchor.constraint(equalTo: leftAnchor, constant: 16)
        ])
    }
}
