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
