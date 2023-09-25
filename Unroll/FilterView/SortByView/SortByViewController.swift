//
//  SortByViewController.swift
//  Unroll
//
//  Created by Gabriel Garcia on 25/09/23.
//

import UIKit

// MARK: - Class

class SortByViewController: UIViewController {
    
    // MARK: - UIComponents
    
    private lazy var sortByView: SortByView = {
        let view = SortByView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.dataSource = self
        view.delegate = self
        return view
    }()
    
    // MARK: - Properties
    
    var selectedSortBy: SortBy = .popularityDesc
    
    // MARK: - Lifecycle
    
    override func loadView() {
        super.loadView()
        view = sortByView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sortByView.selectFirstCell()
    }
}

// MARK: - Collection View DataSource

extension SortByViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return SortBy.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SortByCollectionViewCell.identifier, for: indexPath) as! SortByCollectionViewCell
        let title = SortBy.allCases[indexPath.item].title
        
        cell.setup(with: title, and: Colors.orange)
        
        return cell
    }
}

// MARK: - Collection View Delegate

extension SortByViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedSortBy = SortBy.allCases[indexPath.item]
        self.selectedSortBy = selectedSortBy
    }
}

// MARK: - Collection View Delegate Flow Layout

extension SortByViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
}
