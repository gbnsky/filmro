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
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        return collectionView
    }()
    
    // MARK: - Properties
    
    private var page: Int = .zero
    private var movies: [Movie] = []
    private weak var cellDelegate: ResultCollectionViewCellDelegate?
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Exposed Methods
    
    func setup(with movies: Movies?, and cellDelegate: ResultCollectionViewCellDelegate) {
        guard let movies = movies else {
            return
        }
        self.page = movies.page
        self.movies = movies.results
        self.cellDelegate = cellDelegate
    }
}

// MARK: - Collection View

// data Source

extension ResultView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ResultCollectionViewCell.identifier, for: indexPath) as? ResultCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.setup(with: movies[indexPath.item])
        cell.delegate = cellDelegate
        
        return cell
    }
}

// delegate flow layout

extension ResultView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView.frame.width, height: self.collectionView.frame.height)
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
