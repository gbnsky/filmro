//
//  ResultCollectionViewCell.swift
//  Unroll
//
//  Created by Gabriel Garcia on 12/09/23.
//

import UIKit

class ResultCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Identifier
    
    static let identifier: String = "ResultCollectionViewCell"
    
    // MARK: - UI Components
    
    private lazy var moviePoster: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "placeholder-poster")
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 16
        imageView.layer.borderWidth = 1
        imageView.clipsToBounds = true
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
    
    // MARK: - Private Properties
    
    private var movie: Movie?
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadView()
        setupMoviePoster()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Exposed Methods
    
    func setup(with movie: Movie) {
        self.movie = movie
        
        setupMoviePoster()
    }
    // MARK: - Private Methods
    
    private func setupMoviePoster() {
        guard let posterPath = URL(string: "https://image.tmdb.org/t/p/original/fNOH9f1aA7XRTzl1sAOx9iF553Q.jpg") else {
            return
        }
        
        moviePoster.load(url: posterPath) { imageSize in
            self.updateMoviePosterConstraints(with: imageSize)
        }
    }
    
    private func updateMoviePosterConstraints(with imageSize: CGSize) {        
        NSLayoutConstraint.activate([
            moviePoster.heightAnchor.constraint(equalTo: moviePoster.widthAnchor, multiplier: getImageRatio(width: moviePoster.intrinsicContentSize.width, height: imageSize.height)),
        ])
    }
    
    private func getImageRatio(width: CGFloat, height: CGFloat) -> CGFloat {
        let ratio = height / width
        return ratio
    }
}

// MARK: - View Coding

extension ResultCollectionViewCell {
    
    private func loadView() {
        addSubviews()
        addConstraints()
    }
    
    private func addSubviews() {
        addSubview(moviePoster)
        addSubview(movieTitle)
        addSubview(movieReleaseDateAndRuntime)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
        
            // movie poster
            
            moviePoster.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            moviePoster.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            moviePoster.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            moviePoster.widthAnchor.constraint(equalToConstant: self.frame.width),
            moviePoster.heightAnchor.constraint(equalTo: moviePoster.widthAnchor, multiplier: getImageRatio(width: moviePoster.intrinsicContentSize.width, height: moviePoster.intrinsicContentSize.height)),
            
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
