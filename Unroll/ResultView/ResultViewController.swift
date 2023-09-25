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
        view.dataSource = self
        view.delegate = self
        return view
    }()
    
    // MARK: - Properties
    
    var loadedPage = Int()
    var loadedMovies: [Movie] = []
    
    private var currentMovie: Movie?
    private var movieDetails: Movie?
    private var watchProviders: WatchProvidersResponse?
    
    // MARK: - Lifecycle
    
    override func loadView() {
        super.loadView()
        view = resultView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.beige
    }
}

// MARK: - Collection View DataSource

extension ResultViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return loadedMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ResultCollectionViewCell.identifier, for: indexPath) as! ResultCollectionViewCell
        
        cell.setup(with: loadedMovies[indexPath.item])
        cell.delegate = self
        
        return cell
    }
}

// MARK: - Collection View Delegate Flow Layout

extension ResultViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.resultView.collectionViewFrame.width, height: self.resultView.collectionViewFrame.height)
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
        
        MovieApi.shared.getWatchProvidersResponse(for: movie) { watchProviders in
            self.watchProviders = watchProviders
            fetchGroup.leave()
        }
        
        fetchGroup.notify(queue: .main) {
            self.handleResultDetails()
        }
    }
    
    private func handleResultDetails() {
        guard let movieDetails = movieDetails, let watchProviders = watchProviders else {
            return
        }
        
        let resultDetailsViewController = ResultDetailsViewController()
        resultDetailsViewController.loadedMovie = movieDetails
        resultDetailsViewController.loadedWatchProviders = watchProviders
        self.navigationController?.pushViewController(resultDetailsViewController, animated: true)
    }
}
