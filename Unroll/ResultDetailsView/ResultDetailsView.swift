//
//  ResultDetailsView.swift
//  Unroll
//
//  Created by Gabriel Garcia on 18/09/23.
//

import UIKit

class ResultDetailsView: UIView {
    
    enum Constants {
        // url
        static let baseImageUrl: String = "https://image.tmdb.org/t/p/original/"
    }
    
    // MARK: - UI Components
    
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.showsVerticalScrollIndicator = false
        return view
    }()
    
    private lazy var stackView: UIStackView = {
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
    
    private lazy var movieBackdrop: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "placeholder-backdrop")
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 16
        imageView.layer.borderWidth = 1
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var movieTitle: Card = {
        let card = Card()
        return card
    }()
    
    private lazy var movieOriginalTitle: Card = {
        let card = Card()
        return card
    }()
    
    private lazy var movieTagline: Card = {
        let card = Card()
        return card
    }()
    
    private lazy var movieOverview: Card = {
        let card = Card()
        return card
    }()
    
    private lazy var movieWatchProviders: Card = {
        let card = Card()
        return card
    }()
    
    // MARK: - Private Properties
    
    private var movie: Movie?
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Exposed Methods
    
    func setup(with movie: Movie?) {
        guard let movie = movie else {
            return
        }
        
        self.movie = movie
        
        setupMovieBackdrop()
        setupMovieTitle()
        setupMovieOriginalTitle()
        setupMovieTagline()
        setupMovieOverview()
    }
    
    // MARK: - Private Methods
    
    private func setupMovieBackdrop() {
        guard let movie = movie,
              let movieBackdropPath = movie.backdropPath,
              let backdropPath = URL(string: "\(Constants.baseImageUrl)\(movieBackdropPath)") else {
            movieBackdrop.image = UIImage(named: "placeholder-backdrop")
            return
        }
        
        movieBackdrop.load(url: backdropPath) { imageSize in
            self.updateMovieBackdropConstraints(with: imageSize)
        }
        
        stackView.addArrangedSubview(movieBackdrop)
    }
    
    private func setupMovieTitle() {
        guard let movie = movie,
              let title = movie.title,
              let releaseDate = movie.releaseDate,
              let runtime = movie.runtime else {
            return
        }
        
        if title.isEmpty {
            return
        }
        
        let releaseYear = getFormattedMovieReleaseDate(from: releaseDate)
        let timeMeasure = "m"
        
        movieTitle.title = title
        movieTitle.text = "\(releaseYear) - \(runtime)\(timeMeasure)"
        movieTitle.backgroundTint = Colors.yellow
        
        stackView.addArrangedSubview(movieTitle)
    }
    
    private func setupMovieOriginalTitle() {
        guard let movie = movie,
              let originalLanguage = movie.originalLanguage,
              let originalTitle = movie.originalTitle else {
            return
        }
        let isOriginalLanguage = MovieApi.shared.isOriginalLanguage(originalLanguage)
        
        
        if originalTitle.isEmpty || isOriginalLanguage {
            return
        }
        
        movieOriginalTitle.title = "Original Title".localized()
        movieOriginalTitle.text = originalTitle
        movieOriginalTitle.backgroundTint = Colors.orange
        
        stackView.addArrangedSubview(movieOriginalTitle)
    }
    
    private func setupMovieTagline() {
        guard let movie = movie, let tagline = movie.tagline else {
            return
        }
        
        if tagline.isEmpty {
            return
        }
        
        movieTagline.title = "Tagline".localized()
        movieTagline.text = tagline
        movieTagline.backgroundTint = Colors.pink
        
        stackView.addArrangedSubview(movieTagline)
    }
    
    private func setupMovieOverview() {
        guard let movie = movie, let overview = movie.overview else {
            return
        }
        
        if overview.isEmpty {
            return
        }
        
        movieOverview.title = "Overview".localized()
        movieOverview.text = overview
        movieOverview.backgroundTint = Colors.purple
        
        stackView.addArrangedSubview(movieOverview)
    }
    
    // Helper Methods
    
    private func getFormattedMovieReleaseDate(from releaseDate: String) -> String {
        let separator = String("-")
        let releaseDateArray = releaseDate.components(separatedBy: separator)
        return releaseDateArray.first ?? String()
    }
    
    private func updateMovieBackdropConstraints(with imageSize: CGSize) {
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
