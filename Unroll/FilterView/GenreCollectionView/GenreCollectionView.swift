//
//  GenreCollectionView.swift
//  Unroll
//
//  Created by Gabriel Garcia on 08/09/23.
//

import UIKit

class GenreCollectionView: UIView {
    
    // MARK: - UI Components
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewLayout.init())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.setCollectionViewLayout(layout, animated: false)
        collectionView.register(GenreCollectionViewCell.self, forCellWithReuseIdentifier: GenreCollectionViewCell.identifier)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        return collectionView
    }()
    
    // MARK: - Properties
    
    private var genres: [Genre] = []
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Exposed Methods
    
    func setup(with genres: [Genre]?) {
        guard let genres = genres else {
            return
        }
        self.genres = genres
        print(genres)
    }
}

// MARK: - Collection View Delegate, Data Source and Delegate Flow Layout

extension GenreCollectionView: UICollectionViewDelegate {

}

extension GenreCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return genres.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GenreCollectionViewCell.identifier, for: indexPath) as? GenreCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.setup(with: genres[indexPath.item].name, and: Colors.yellow)
        
        return cell
    }
}

extension GenreCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
}

// MARK: - View Coding

extension GenreCollectionView {
    
    private func loadView() {
        addSubviews()
        addConstraints()
    }
    
    private func addSubviews() {
        addSubview(collectionView)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            
            // collection view
            
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.leftAnchor.constraint(equalTo: leftAnchor)
        ])
    }
}
