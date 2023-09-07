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
        return view
    }()
    
    // MARK: - Life cycle
    
    override func loadView() {
        view = filterView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.996, green: 0.98, blue: 0.933, alpha: 1)
    }
}
