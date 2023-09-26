//
//  ResultDetailsView.swift
//  Unroll
//
//  Created by Gabriel Garcia on 18/09/23.
//

import UIKit

class ResultDetailsView: UIView {
    
    // MARK: - Exposed UI Components
    
    lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: UIApplication.safeAreaEdgeInsets.bottom + 16, right: 16)
        view.isLayoutMarginsRelativeArrangement = true
        view.axis = .vertical
        view.spacing = 16
        view.alignment = .fill
        view.distribution = .fill
        return view
    }()
    
    lazy var movieBackdrop: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "placeholder-backdrop")
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 16
        imageView.layer.borderWidth = 1
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var movieTitle: Card = {
        let card = Card()
        return card
    }()
    
    lazy var movieOriginalTitle: Card = {
        let card = Card()
        return card
    }()
    
    lazy var movieTagline: Card = {
        let card = Card()
        return card
    }()
    
    lazy var movieOverview: Card = {
        let card = Card()
        return card
    }()
    
    lazy var movieWatchProviders: WatchProvidersView = {
        let view = WatchProvidersView()
        return view
    }()
    
    // MARK: - Private UI Components
    
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.showsVerticalScrollIndicator = false
        return view
    }()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods

    func updateMovieBackdropConstraints(with imageSize: CGSize) {
        NSLayoutConstraint.activate([
            movieBackdrop.heightAnchor.constraint(equalTo: movieBackdrop.widthAnchor, multiplier: movieBackdrop.fullWidthRatio()),
        ])
    }
}

// MARK: - View Coding

extension ResultDetailsView {
    
    private func loadView() {
        addSubviews()
        addConstraints()
        addAdditionalConstraints()
    }
    
    private func addSubviews() {
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
            
            // movie backdrop
            
            movieBackdrop.heightAnchor.constraint(equalTo: movieBackdrop.widthAnchor, multiplier: movieBackdrop.fullWidthRatio())
            
        ])
    }
}
