//
//  CreditView.swift
//  Unroll
//
//  Created by Gabriel Garcia on 19/09/23.
//

import UIKit

// MARK: - Class

class CreditView: UIView {
    
    // MARK: - UI Components

    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.showsVerticalScrollIndicator = false
        view.bounces = false
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layoutMargins = UIEdgeInsets(top: 32, left: 16, bottom: .zero, right: 16)
        view.isLayoutMarginsRelativeArrangement = true
        view.axis = .vertical
        view.spacing = 16
        view.alignment = .fill
        view.distribution = .fill
        return view
    }()
    
    private lazy var tmdbLogo: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "tmdb")
        imageView.contentMode = .scaleAspectFit
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
        label.text = "Film Data".localized()
        return label
    }()
    
    private lazy var text: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Colors.blackOne
        label.font = UIFont(name: Fonts.kanitRegular, size: 16)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .justified
        label.text = "All film data used on Unroll are supplied by The Movie Database. If you want to add or modify any movie informartion that seems off, you can tap here, create an account on TMDb and do the specific changes. Rolly will appreciate that.".localized()
        return label
    }()
    
    private lazy var secondaryText: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Colors.orange
        label.font = UIFont(name: Fonts.kanitRegular, size: 16)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.text = "This app were designed and developed by\nGabriel Garcia.".localized()
        return label
    }()
    
    private lazy var mascot: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "rolly-lookup")
        imageView.contentMode = .scaleAspectFit
        return imageView
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

extension CreditView {
    
    private func loadView() {
        addSubviews()
        addConstraints()
        addAdditionalConstraints()
    }
    
    private func addSubviews() {
        stackView.addArrangedSubview(tmdbLogo)
        stackView.addArrangedSubview(title)
        stackView.addArrangedSubview(text)
        stackView.addArrangedSubview(secondaryText)
        stackView.addArrangedSubview(mascot)
        scrollView.addSubview(stackView)
        addSubview(scrollView)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
        
            // scroll view
            
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.rightAnchor.constraint(equalTo: rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            scrollView.leftAnchor.constraint(equalTo: leftAnchor),
            
            // stack view
            
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

        ])
    }
    
    private func addAdditionalConstraints() {
        NSLayoutConstraint.activate([
            
            // logo
            
            tmdbLogo.heightAnchor.constraint(equalToConstant: 72),
            
            // mascot

            mascot.heightAnchor.constraint(equalTo: mascot.widthAnchor, multiplier: mascot.fullHeightRatio()),
        ])
    }
}
