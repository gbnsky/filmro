//
//  GenreCollectionViewCell.swift
//  Unroll
//
//  Created by Gabriel Garcia on 08/09/23.
//

import UIKit

class GenreCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Identifier
    
    static let identifier: String = "GenreCollectionViewCell"
    
    // MARK: - UI Components
    
    private lazy var title: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Colors.blackOne
        label.font = UIFont(name: Fonts.kanitRegular, size: 16)
        label.numberOfLines = 3
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStyle()
        loadView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Exposed Methods
    
    func setup(with title: String, and backgroundColor: UIColor) {
        self.title.text = title
        self.backgroundColor = backgroundColor
    }
    
    // MARK: - Private Methods
    
    private func setupStyle() {
        layer.borderColor = Colors.blackOne.cgColor
        layer.cornerRadius = 16
        clipsToBounds = true
    }
}

// MARK: - View Coding

extension GenreCollectionViewCell {
    
    private func loadView() {
        addSubviews()
        addConstraints()
    }
    
    private func addSubviews() {
        addSubview(title)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
        
            // title
            
            title.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            title.rightAnchor.constraint(equalTo: rightAnchor, constant: -8),
            title.leftAnchor.constraint(equalTo: leftAnchor, constant: 8)
            
        ])
    }
}
