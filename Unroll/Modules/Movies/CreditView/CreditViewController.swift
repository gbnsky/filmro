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
        setupGestures()
    }
    
    // MARK: - Methods
    
    private func setupGestures() {
        setupTmdbGesture()
        setupJustWatchGesture()
        setupAboutGesture()
    }
    
    private func setupTmdbGesture() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(openTmdb))
        creditView.tmdbText.isUserInteractionEnabled = true
        creditView.tmdbText.addGestureRecognizer(gesture)
    }
    
    private func setupJustWatchGesture() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(openJustWatch))
        creditView.justWatchText.isUserInteractionEnabled = true
        creditView.justWatchText.addGestureRecognizer(gesture)
    }
    
    private func setupAboutGesture() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(openAbout))
        creditView.aboutText.isUserInteractionEnabled = true
        creditView.aboutText.addGestureRecognizer(gesture)
    }
}

// MARK: - Actions

extension CreditViewController {
    
    @objc
    internal func openTmdb() {
        guard let url = URL(string: "https://www.themoviedb.org") else {
            return
        }
        
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    
    @objc
    internal func openJustWatch() {
        guard let url = URL(string: "https://www.justwatch.com") else {
            return
        }
        
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    
    @objc
    internal func openAbout() {
        guard let url = URL(string: "https://www.linkedin.com/in/ggarciamartins/") else {
            return
        }
        
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
}
