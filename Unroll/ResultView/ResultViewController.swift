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
}

// MARK: - Delegates

extension ResultViewController: ResultCollectionViewCellDelegate {

    func fetchResultDetails(from movie: Movie) {
        let group = DispatchGroup()
        group.enter()
        
        MovieApi.shared.getMovieDetails(from: movie) { movieDetails in
            self.movieDetails = movieDetails
            group.leave()
        }
        
        group.notify(queue: .main) {
            
            let resultDetailsViewController = ResultDetailsViewController()
            resultDetailsViewController.setup(with: self.movieDetails)
            self.navigationController?.pushViewController(resultDetailsViewController, animated: true)
        }
    }
}
