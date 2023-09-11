//
//  ResultView.swift
//  Unroll
//
//  Created by Gabriel Garcia on 11/09/23.
//

import UIKit

// MARK: - Class

class ResultView: UIView {
    
    // MARK: - UI Components
    
    private lazy var title: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Colors.blackOne
        label.font = UIFont(name: Fonts.breeSerif, size: 24)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.text = "Is this your movie?"
        return label
    }()
    
    private lazy var moviePoster: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "movie-poster")
        imageView.contentMode = .scaleAspectFit
        imageView.layer.borderWidth = 1
        return imageView
    }()
    
    private lazy var movieTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Colors.blackOne
        label.font = UIFont(name: Fonts.breeSerif, size: 24)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.text = "Back to the Future"
        return label
    }()
    
    private lazy var movieReleaseDateAndRuntime: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Colors.blackOne
        label.font = UIFont(name: Fonts.kanitRegular, size: 16)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.text = "1985 - 1h56m"
        return label
    }()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func getImageRatio() -> CGFloat {
        let ratio = moviePoster.intrinsicContentSize.height / moviePoster.intrinsicContentSize.width
        return ratio
    }
}

// MARK: - View Coding

extension ResultView {
    
    private func loadView() {
        addSubviews()
        addConstraints()
    }
    
    private func addSubviews() {
        addSubview(title)
        addSubview(moviePoster)
        addSubview(movieTitle)
        addSubview(movieReleaseDateAndRuntime)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
        
            // title
            
            title.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 32),
            title.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            
            // logo
            
            moviePoster.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 16),
            moviePoster.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            moviePoster.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            moviePoster.widthAnchor.constraint(equalToConstant: self.frame.width),
            moviePoster.heightAnchor.constraint(equalTo: moviePoster.widthAnchor, multiplier: getImageRatio()),
            
            // movie title
            
            movieTitle.topAnchor.constraint(equalTo: moviePoster.bottomAnchor, constant: 16),
            movieTitle.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            movieTitle.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            
            // movie release date and runtime
            
            movieReleaseDateAndRuntime.topAnchor.constraint(equalTo: movieTitle.bottomAnchor),
            movieReleaseDateAndRuntime.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            movieReleaseDateAndRuntime.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
        ])
    }
}
