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
        label.text = "Sort By".localized()
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
        
        return collectionView
    }()
    
    // MARK: - Properties
    
    weak var dataSource: UICollectionViewDataSource? {
        didSet {
            collectionView.dataSource = dataSource
        }
    }
    
    weak var delegate: UICollectionViewDelegate? {
        didSet {
            collectionView.delegate = delegate
        }
    }
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    func selectFirstCell() {
        let indexPath = IndexPath(item: .zero, section: .zero)
        self.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .right)
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
