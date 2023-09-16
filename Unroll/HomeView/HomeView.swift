//
//  HomeView.swift
//  Unroll
//
//  Created by Gabriel Garcia on 06/09/23.
//

import UIKit

// MARK: - Delegate

protocol HomeViewDelegate: AnyObject {
    func homeButtonAction()
}

// MARK: - Class

class HomeView: UIView {
    
    // MARK: - UI Components
    
    private lazy var logo: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "unroll")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var mascot: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "rolly")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var title: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Colors.blackOne
        label.font = UIFont(name: Fonts.breeSerif, size: 40)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.text = "A shortcut for the next streaming."
        return label
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Let’s find a movie together", for: .normal)
        button.setTitleColor(Colors.blackOne, for: .normal)
        button.titleLabel?.font = UIFont(name: Fonts.kanitRegular, size: 16)
        button.backgroundColor = Colors.yellow
        button.layer.borderColor = Colors.blackOne.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 24
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Properties
    
    weak var delegate: HomeViewDelegate?
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Actions

extension HomeView {
    
    @objc
    private func buttonAction() {
        delegate?.homeButtonAction()
    }
}

// MARK: - View Coding

extension HomeView {
    
    private func loadView() {
        addSubviews()
        addConstraints()
    }
    
    private func addSubviews() {
        addSubview(logo)
        addSubview(mascot)
        addSubview(title)
        addSubview(button)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
        
            // logo
            
            logo.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            logo.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            logo.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            logo.heightAnchor.constraint(equalToConstant: 160),
            
            // logo
            
            mascot.bottomAnchor.constraint(equalTo: title.topAnchor),
            mascot.widthAnchor.constraint(equalTo: widthAnchor),
            mascot.heightAnchor.constraint(equalToConstant: 300),
            mascot.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            // title
            
            title.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            title.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -32),
            title.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            
            // button
            
            button.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            button.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -32),
            button.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            button.heightAnchor.constraint(equalToConstant: 48)
            
        ])
    }
}
