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
    
    // MARK: - Life cycle
    
    override func loadView() {
        super.loadView()
        view = filterView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.beige
        
        fetchMovieGenres()
        fetchMovieDiscoveries()
    }
    
    // MARK: - Private Methods
    
    private func fetchMovieGenres() {
        MovieApi.shared.getMovieGenreList { genres in
            self.filterView.setupGenreCollectionView(with: genres)
        }
    }
    
    private func fetchMovieDiscoveries() {
        MovieApi.shared.getMovieDiscoverList { discoveries in
            guard let discoveries = discoveries else {
                return
            }
            print(discoveries)
            print(discoveries.results.count)
        }
    }
}

// MARK: - Delegates

extension FilterViewController: FilterViewDelegate {
    func filterButtonAction() {
        let resultViewController = ResultViewController()
        navigationController?.pushViewController(resultViewController, animated: true)
    }
}
