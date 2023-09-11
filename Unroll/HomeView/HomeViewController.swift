//
//  ViewController.swift
//  Unroll
//
//  Created by Gabriel Garcia on 02/09/23.
//

import UIKit

class HomeViewController: UIViewController {

    // MARK: - UI Components
    
    private lazy var homeView: HomeView = {
        let view = HomeView()
        view.delegate = self
        return view
    }()
    
    // MARK: - Lifecycle
    
    override func loadView() {
        super.loadView()
        view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.beige
    }
}

// MARK: - Delegates

extension HomeViewController: HomeViewDelegate {
    func homeButtonAction() {
        let filterViewController = FilterViewController()
        navigationController?.pushViewController(filterViewController, animated: true)
    }
}
