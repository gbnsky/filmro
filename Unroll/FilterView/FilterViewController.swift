//
//  FilterViewController.swift
//  Unroll
//
//  Created by Gabriel Garcia on 07/09/23.
//

import UIKit

class FilterViewController: UIViewController {
    
    // MARK: - UI Components
    
    private lazy var filterView: FilterView = {
        let view = FilterView()
        view.delegate = self
        return view
    }()
    
    // MARK: - Properties
    
    private var movies: Movies?
    
    // MARK: - Lifecycle
    
    override func loadView() {
        super.loadView()
        view = filterView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.beige
    }
    
    // MARK: - Private Methods

    private func openErrorAlert() {
        let alert = UIAlertController(title: "This roll has no film ):".localized(),
                                      message: "There are no results with the selected features. Please, try different ones.".localized(),
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        
        self.present(alert, animated: true)
    }
}

// MARK: - Delegates

extension FilterViewController: FilterViewDelegate {
    
    func fetchResults() {
        let filter = makeFilter()
        let group = DispatchGroup()
        group.enter()
        
        MovieApi.shared.getMovieDiscoverList(filter: filter) { discoveries in
            self.movies = discoveries
            group.leave()
        }
        
        group.notify(queue: .main) {
            self.handleFetchedMovies()
        }
    }
    
    private func handleFetchedMovies() {
        guard let movies = self.movies, !movies.results.isEmpty else {
            self.openErrorAlert()
            return
        }
        
        let resultViewController = ResultViewController()
        resultViewController.loadedPage = movies.page
        resultViewController.loadedMovies = movies.results
        self.navigationController?.pushViewController(resultViewController, animated: true)
    }
    
    private func makeFilter() -> Filter {
        return Filter(page: "1",
                       sortBy: filterView.sortBy,
                       genres: filterView.genres,
                       watchProviders: filterView.watchProviders)
    }
}
