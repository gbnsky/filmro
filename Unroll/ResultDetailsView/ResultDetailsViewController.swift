//
//  ResultDetailsViewController.swift
//  Unroll
//
//  Created by Gabriel Garcia on 18/09/23.
//

import UIKit

class ResultDetailsViewController: UIViewController {
    
    // MARK: - UI Components
    
    private lazy var resultDetaisView: ResultDetailsView = {
        let view = ResultDetailsView()
        return view
    }()
    
    // MARK: - Lifecycle
    
    override func loadView() {
        super.loadView()
        view = resultDetaisView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.beige
    }
    
    // MARK: - Methods
    
    func setup(with movie: Movie?) {
        resultDetaisView.setup(with: movie)
    }
    
    func setupWatchProviders(with watchProviders: WatchProvidersResponse?) {
        resultDetaisView.setupWatchProviders(with: watchProviders)
    }
}
