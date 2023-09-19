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
    
    private lazy var tmdbTitle: UILabel = {
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
    
    private lazy var tmdbText: UILabel = {
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
    
    private lazy var justWatchLogo: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "just-watch")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var justWatchTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Colors.blackOne
        label.font = UIFont(name: Fonts.breeSerif, size: 32)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.text = "Watch Providers Data".localized()
        return label
    }()
    
    private lazy var justWatchText: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Colors.blackOne
        label.font = UIFont(name: Fonts.kanitRegular, size: 16)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .justified
        label.text = "Watch providers data are related to JustWatch. If you want to know more about it, just tap here.".localized()
        return label
    }()
    
    private lazy var aboutText: UILabel = {
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
        addCustomSpacings()
    }
    
    private func addSubviews() {
        stackView.addArrangedSubview(tmdbLogo)
        stackView.addArrangedSubview(tmdbTitle)
        stackView.addArrangedSubview(tmdbText)
        stackView.addArrangedSubview(justWatchLogo)
        stackView.addArrangedSubview(justWatchTitle)
        stackView.addArrangedSubview(justWatchText)
        stackView.addArrangedSubview(aboutText)
        scrollView.addSubview(stackView)
        scrollView.addSubview(mascot)
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
            stackView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            // mascot
            
            mascot.topAnchor.constraint(equalTo: stackView.bottomAnchor),
            mascot.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: UIApplication.safeAreaEdgeInsets.bottom),
            mascot.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            mascot.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }
    
    private func addAdditionalConstraints() {
        NSLayoutConstraint.activate([
            
            // tmdb logo
            
            tmdbLogo.heightAnchor.constraint(equalToConstant: 72),
            
            // just watch
            
            justWatchLogo.heightAnchor.constraint(equalToConstant: 32),
            
            // mascot

            mascot.heightAnchor.constraint(equalTo: mascot.widthAnchor, multiplier: mascot.fullHeightRatio()),
        ])
    }
    
    private func addCustomSpacings() {
        
        // tmdb text
        
        stackView.setCustomSpacing(32, after: tmdbText)
        
        // just watch text
        
        stackView.setCustomSpacing(32, after: justWatchText)
        
        // about text
        
        stackView.setCustomSpacing(.zero, after: aboutText)
    }
}
