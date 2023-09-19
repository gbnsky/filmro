//
//  CreditViewController.swift
//  Unroll
//
//  Created by Gabriel Garcia on 19/09/23.
//

import UIKit

class CreditViewController: UIViewController {

    // MARK: - UI Components
    
    private lazy var creditView: CreditView = {
        let view = CreditView()
        return view
    }()
    
    // MARK: - Lifecycle
    
    override func loadView() {
        super.loadView()
        view = creditView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.beige
    }
}
