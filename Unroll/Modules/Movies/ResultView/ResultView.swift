//
//  ResultView.swift
//  Unroll
//
//  Created by Gabriel Garcia on 11/09/23.
//

import UIKit

// MARK: - Class

class ResultView: UIView {
    
    // MARK: - UI Components
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layoutMargins = UIEdgeInsets(top: .zero, left: .zero, bottom: .zero, right: .zero)
        view.isLayoutMarginsRelativeArrangement = true
        view.axis = .vertical
        view.spacing = 16
        view.alignment = .fill
        view.distribution = .fill
        return view
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = .zero
        layout.minimumInteritemSpacing = .zero
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewLayout.init())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = .none
        collectionView.setCollectionViewLayout(layout, animated: false)
        collectionView.register(ResultCollectionViewCell.self, forCellWithReuseIdentifier: ResultCollectionViewCell.identifier)
        
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
    
    var collectionViewFrame: CGRect {
        get {
            return self.collectionView.frame
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
}

// MARK: - View Coding

extension ResultView {
    
    private func loadView() {
        addSubviews()
        addConstraints()
    }
    
    private func addSubviews() {
        stackView.addArrangedSubview(collectionView)
        addSubview(stackView)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
        
            // stack view
            
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.rightAnchor.constraint(equalTo: rightAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: UIApplication.safeAreaEdgeInsets.bottom),
            stackView.leftAnchor.constraint(equalTo: leftAnchor),
        ])
    }
}

