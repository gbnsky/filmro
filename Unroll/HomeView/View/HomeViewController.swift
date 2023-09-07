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
        view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.996, green: 0.98, blue: 0.933, alpha: 1)
    }
}

// MARK: - Delegates

extension HomeViewController: HomeViewDelegate {
    func homeButtonAction() {
        print(#function)
    }
}
