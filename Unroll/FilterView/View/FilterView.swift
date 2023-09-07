//
//  FilterView.swift
//  Unroll
//
//  Created by Gabriel Garcia on 07/09/23.
//

import UIKit

class FilterView: UIView {
        
    // MARK: - UI Components
    
    private lazy var title: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Colors.blackOne
        label.font = UIFont(name: Fonts.breeSerif, size: 24)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.text = "Just like Subway,\nchoose the ingredients."
        return label
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Continue", for: .normal)
        button.setTitleColor(Colors.blackOne, for: .normal)
        button.titleLabel?.font = UIFont(name: Fonts.kanitRegular, size: 16)
        button.backgroundColor = Colors.orange
        button.layer.borderColor = Colors.blackOne.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 24
        return button
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

extension FilterView {
    
    private func loadView() {
        addSubviews()
        addConstraints()
    }
    
    private func addSubviews() {
        addSubview(title)
        addSubview(button)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            
            // title
            
            title.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            title.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            title.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            
            // button
            
            button.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            button.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -32),
            button.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            button.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
}
