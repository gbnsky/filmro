//
//  ResultViewController.swift
//  Unroll
//
//  Created by Gabriel Garcia on 11/09/23.
//

import UIKit

class ResultViewController: UIViewController {
    
    // MARK: - UI Components
    
    private lazy var resultView: ResultView = {
        let view = ResultView()
        return view
    }()
    
    // MARK: - Properties
    
    private var currentMovie: Movie?
    private var movieDetails: Movie?
    private var watchProviders: WatchProviders?
    
    // MARK: - Lifecycle
    
    override func loadView() {
        super.loadView()
        view = resultView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.beige
    }
    
    // MARK: - Exposed Methods
    
    func setupFilteredMovies(with movies: Movies) {
        resultView.setup(with: movies, and: self)
    }
    
    // MARK: - Private Methods
    
    private func openResultDetails() {
        let viewGroup = DispatchGroup()
        
        viewGroup.enter()
        
        let resultDetailsViewController = ResultDetailsViewController()
        
        resultDetailsViewController.setup(with: self.movieDetails)

        if let watchProviders = self.watchProviders {
            print("watch providers: \(watchProviders)")
        }
        
        self.navigationController?.pushViewController(resultDetailsViewController, animated: true)
    }
}

// MARK: - Delegates

extension ResultViewController: ResultCollectionViewCellDelegate {

    func fetchResultDetails(from movie: Movie) {
        let fetchGroup = DispatchGroup()
        
        fetchGroup.enter()
        
        MovieApi.shared.getMovieDetails(from: movie) { movieDetails in
            self.movieDetails = movieDetails
            fetchGroup.leave()
        }
        
        fetchGroup.enter()
        
        MovieApi.shared.getWatchProviders(for: movie) { watchProviders in
            self.watchProviders = watchProviders
            fetchGroup.leave()
        }
        
        fetchGroup.notify(queue: .main) {
            self.openResultDetails()
        }
    }
}
