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
        label.font = UIFont(name: Fonts.breeSerif, size: 32)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.text = "A shortcut to next streaming"
        return label
    }()
    
    private lazy var text: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Colors.blackOne
        label.font = UIFont(name: Fonts.kanitRegular, size: 16)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.text = "We'll try to spare your time before countless scrolling time to find something to watch."
        return label
    }()
    
    private lazy var settingsButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Settings", for: .normal)
        button.setTitleColor(Colors.blackOne, for: .normal)
        button.titleLabel?.font = UIFont(name: Fonts.kanitRegular, size: 16)
        button.backgroundColor = Colors.orange
        button.layer.borderColor = Colors.blackOne.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 24
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var continueButton: UIButton = {
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
        addSubview(title)
        addSubview(mascot)
        addSubview(text)
        addSubview(settingsButton)
        addSubview(continueButton)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
        
            // logo
            
            logo.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            logo.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            logo.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            logo.heightAnchor.constraint(equalToConstant: 50),
            
            // title
            
            title.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 32),
            title.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            title.bottomAnchor.constraint(equalTo: mascot.topAnchor, constant: -16),
            title.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            
            // mascot
            
            mascot.topAnchor.constraint(equalTo: title.bottomAnchor),
            mascot.widthAnchor.constraint(equalTo: widthAnchor),
            mascot.heightAnchor.constraint(equalToConstant: 250),
            mascot.centerXAnchor.constraint(equalTo: centerXAnchor),
            mascot.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            // text
            
            text.topAnchor.constraint(equalTo: mascot.bottomAnchor),
            text.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            text.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            
            // settings button
            
            settingsButton.topAnchor.constraint(equalTo: text.bottomAnchor),
            settingsButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            settingsButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            settingsButton.heightAnchor.constraint(equalToConstant: 48),
            
            // continue button
            
            continueButton.topAnchor.constraint(equalTo: settingsButton.bottomAnchor, constant: 16),
            continueButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            continueButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -32),
            continueButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            continueButton.heightAnchor.constraint(equalToConstant: 48)
            
        ])
    }
}
