//
//  ResultDetailsViewController.swift
//  Unroll
//
//  Created by Gabriel Garcia on 18/09/23.
//

import UIKit

class ResultDetailsViewController: UIViewController {
    
    // MARK: - Constants
    
    enum Constants {
        // url
        static let baseImageUrl: String = "https://image.tmdb.org/t/p/original/"
    }
    
    // MARK: - UI Components
    
    private lazy var resultDetaisView: ResultDetailsView = {
        let view = ResultDetailsView()
        return view
    }()
    
    // MARK: - Properties
    
    var loadedMovie: Movie?
    var loadedWatchProviders: WatchProvidersResponse?
    
    // MARK: - Lifecycle
    
    override func loadView() {
        super.loadView()
        view = resultDetaisView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.beige
        setupView()
    }
}

// MARK: - View Setup

extension ResultDetailsViewController {
    
    private func setupView() {
        setupMovieBackdrop()
        setupMovieTitle()
        setupMovieOriginalTitle()
        setupMovieTagline()
        setupMovieOverview()
        setupMovieWatchProviders()
    }
    
    private func setupMovieBackdrop() {
        guard let movie = loadedMovie,
              let movieBackdropPath = movie.backdropPath,
              let backdropPath = URL(string: "\(Constants.baseImageUrl)\(movieBackdropPath)") else {
            
            resultDetaisView.movieBackdrop.image = UIImage(named: "placeholder-backdrop")
            return
        }
        
        resultDetaisView.movieBackdrop.load(url: backdropPath) { imageSize in
            self.resultDetaisView.updateMovieBackdropConstraints(with: imageSize)
        }
        
        resultDetaisView.stackView.addArrangedSubview(resultDetaisView.movieBackdrop)
    }
    
    private func setupMovieTitle() {
        guard let movie = loadedMovie,
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
        
        resultDetaisView.movieTitle.title = title
        resultDetaisView.movieTitle.text = "\(releaseYear) - \(runtime)\(timeMeasure)"
        resultDetaisView.movieTitle.backgroundTint = Colors.yellow
        
        resultDetaisView.stackView.addArrangedSubview(resultDetaisView.movieTitle)
    }
    
    private func setupMovieOriginalTitle() {
        guard let movie = loadedMovie,
              let originalLanguage = movie.originalLanguage,
              let originalTitle = movie.originalTitle else {
            return
        }
        let isOriginalLanguage = MovieApi.shared.isOriginalLanguage(originalLanguage)
        
        
        if originalTitle.isEmpty || isOriginalLanguage {
            return
        }
        
        resultDetaisView.movieOriginalTitle.title = "Original Title".localized()
        resultDetaisView.movieOriginalTitle.text = originalTitle
        resultDetaisView.movieOriginalTitle.backgroundTint = Colors.orange
        
        resultDetaisView.stackView.addArrangedSubview(resultDetaisView.movieOriginalTitle)
    }
    
    private func setupMovieTagline() {
        guard let movie = loadedMovie, let tagline = movie.tagline else {
            return
        }
        
        if tagline.isEmpty {
            return
        }
        
        resultDetaisView.movieTagline.title = "Tagline".localized()
        resultDetaisView.movieTagline.text = tagline
        resultDetaisView.movieTagline.backgroundTint = Colors.pink
        
        resultDetaisView.stackView.addArrangedSubview(resultDetaisView.movieTagline)
    }
    
    private func setupMovieOverview() {
        guard let movie = loadedMovie, let overview = movie.overview else {
            return
        }
        
        if overview.isEmpty {
            return
        }
        
        resultDetaisView.movieOverview.title = "Overview".localized()
        resultDetaisView.movieOverview.text = overview
        resultDetaisView.movieOverview.backgroundTint = Colors.purple
        
        resultDetaisView.stackView.addArrangedSubview(resultDetaisView.movieOverview)
    }
    
    private func setupMovieWatchProviders() {
        if getWatchProvidersNames().isEmpty {
            return
        }
        
        resultDetaisView.movieWatchProviders.title = "Watch Providers".localized()
        resultDetaisView.movieWatchProviders.text = getWatchProvidersNames()
        resultDetaisView.movieWatchProviders.backgroundTint = Colors.green
        
        resultDetaisView.stackView.addArrangedSubview(resultDetaisView.movieWatchProviders)
    }
    
    // MARK: - Helper Methods
    
    private func getFormattedMovieReleaseDate(from releaseDate: String) -> String {
        let separator = String("-")
        let releaseDateArray = releaseDate.components(separatedBy: separator)
        return releaseDateArray.first ?? String()
    }
    
    private func getWatchProvidersNames() -> String {
        guard let watchProviders = loadedWatchProviders else {
            return String()
        }
        
        let helper = WatchProvidersResponseHelper(watchProviders: watchProviders)
        var watchProvidersNames = String()

        let providers = helper.getFlatrateWatchProvidersNames()
        if !providers.isEmpty {
            watchProvidersNames.append(providers)
        }
        
        return watchProvidersNames
    }
}
