//
//  SortByView.swift
//  Unroll
//
//  Created by Gabriel Garcia on 14/09/23.
//

import UIKit

class SortByView: UIView {
    
    // MARK: - UI Components
    
    private lazy var title: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Colors.blackOne
        label.font = UIFont(name: Fonts.breeSerif, size: 16)
        label.numberOfLines = 3
        label.lineBreakMode = .byTruncatingTail
        label.text = "Sort By"
        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 16
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewLayout.init())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .none
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        collectionView.setCollectionViewLayout(layout, animated: false)
        collectionView.register(SortByCollectionViewCell.self, forCellWithReuseIdentifier: SortByCollectionViewCell.identifier)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        return collectionView
    }()
    
    // MARK: - Properties
    
    private var selectedSortBy: SortBy = .popularityDesc
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadView()
        selectFirstCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Exposed Methods
    
    func getSelectedSortBy() -> SortBy {
        return selectedSortBy
    }
    
    // MARK: - Private Methods
    
    private func selectFirstCell() {
        DispatchQueue.main.async {
            let indexPath = IndexPath(item: .zero, section: .zero)
            self.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .right)
            self.collectionView(self.collectionView, didSelectItemAt: indexPath)
        }
    }
}

// MARK: - Collection View

// delegate

extension SortByView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? SortByCollectionViewCell else {
            return
        }
        
        let selectedSortBy = SortBy.allCases[indexPath.item]
        self.selectedSortBy = selectedSortBy
        cell.select()
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? SortByCollectionViewCell else {
            return
        }
        cell.deselect()
    }
}

// data Source

extension SortByView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return SortBy.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SortByCollectionViewCell.identifier, for: indexPath) as? SortByCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let title = SortBy.allCases[indexPath.item].title
        
        cell.setup(with: title, and: Colors.orange)
        
        return cell
    }
}

// delegate flow layout

extension SortByView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
}

// MARK: - View Coding

extension SortByView {
    
    private func loadView() {
        addSubviews()
        addConstraints()
    }
    
    private func addSubviews() {
        addSubview(title)
        addSubview(collectionView)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            
            // title
            
            title.topAnchor.constraint(equalTo: topAnchor),
            title.rightAnchor.constraint(equalTo: rightAnchor),
            title.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            
            // collection view
            
            collectionView.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 16),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.leftAnchor.constraint(equalTo: leftAnchor)
        ])
    }
}
