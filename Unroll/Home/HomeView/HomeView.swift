//
//  HomeView.swift
//  Unroll
//
//  Created by Gabriel Garcia on 06/09/23.
//

import UIKit

class HomeView: UIView {
    
    // MARK: - Constants
    
    enum Constants {
        // colors
        static let blackOne = UIColor(red: 0.2, green: 0.216, blue: 0.275, alpha: 1)
        static let yellow = UIColor(red: 0.996, green: 0.796, blue: 0.4, alpha: 1)
    }
    
    // MARK: - UI Components
    
    private lazy var title: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Constants.blackOne
        label.font = UIFont(name: "BreeSerif-Regular", size: 40)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.text = "The last place you’ll search. Seriously."
        return label
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Let’s find a movie together", for: .normal)
        button.setTitleColor(Constants.blackOne, for: .normal)
        button.titleLabel?.font = UIFont(name: "Kanit-Regular", size: 16)
        button.backgroundColor = Constants.yellow
        button.layer.borderColor = Constants.blackOne.cgColor
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

extension HomeView {
    
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
            
            title.rightAnchor.constraint(equalTo: rightAnchor, constant: 16),
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
