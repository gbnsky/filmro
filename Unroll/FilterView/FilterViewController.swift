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
    
    // MARK: - Life cycle
    
    override func loadView() {
        super.loadView()
        view = filterView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.beige
        
        fetchMovieGenres()
    }
    
    // MARK: - Private Methods
    
    private func fetchMovieGenres() {
        MovieApi.shared.getMovieGenreList { genres in
            self.filterView.setupGenreView(with: genres)
        }
    }
}

// MARK: - Delegates

extension FilterViewController: FilterViewDelegate {
    
    func fetchResults(with filters: Filters) {
        let group = DispatchGroup()
        group.enter()
        
        MovieApi.shared.getMovieDiscoverList(filters: filters) { discoveries in
            self.movies = discoveries
            group.leave()
        }
        
        group.notify(queue: .main) {
            
            guard let movies = self.movies else {
                return
            }
            
            let resultViewController = ResultViewController()
            resultViewController.setupFilteredMovies(with: movies)
            self.navigationController?.pushViewController(resultViewController, animated: true)
        }
    }
}
