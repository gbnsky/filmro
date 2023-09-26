//
//  Card.swift
//  Unroll
//
//  Created by Gabriel Garcia on 18/09/23.
//

import UIKit

class Card: UIView {
    
    // MARK: - UI Components
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        view.isLayoutMarginsRelativeArrangement = true
        view.axis = .vertical
        view.spacing = 16
        view.alignment = .fill
        view.distribution = .fill
        view.layer.cornerRadius = 16
        view.layer.borderWidth = 1
        view.layer.borderColor = Colors.blackOne.cgColor
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var cardTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Colors.blackOne
        label.font = UIFont(name: Fonts.breeSerif, size: 24)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private lazy var cardDescription: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Colors.blackOne
        label.font = UIFont(name: Fonts.kanitRegular, size: 16)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    // MARK: - Properties
    
    var title = String() {
        didSet {
            cardTitle.text = title
        }
    }
    
    var text = String() {
        didSet {
            cardDescription.text = text
        }
    }
    
    var backgroundTint = UIColor.clear {
        didSet {
            stackView.backgroundColor = backgroundTint
        }
    }
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Exposed Methods
    
    func setup(title: String, description: String, backgroundColor: UIColor) {
        cardTitle.text = title
        cardDescription.text = description
        stackView.backgroundColor = backgroundColor
    }
}

// MARK: - View Coding

extension Card {
    
    private func loadView() {
        addSubviews()
        addConstraints()
    }
    
    private func addSubviews() {
        stackView.addArrangedSubview(cardTitle)
        stackView.addArrangedSubview(cardDescription)
        addSubview(stackView)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            
            // stack view
            
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.rightAnchor.constraint(equalTo: rightAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.leftAnchor.constraint(equalTo: leftAnchor),
            
        ])
    }
}
