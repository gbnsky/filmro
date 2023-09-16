//
//  GenreView.swift
//  Unroll
//
//  Created by Gabriel Garcia on 08/09/23.
//

import UIKit

class GenreView: UIView {
    
    // MARK: - UI Components
    
    private lazy var title: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Colors.blackOne
        label.font = UIFont(name: Fonts.breeSerif, size: 16)
        label.numberOfLines = 3
        label.lineBreakMode = .byTruncatingTail
        label.text = "Genres".localized()
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
        collectionView.allowsMultipleSelection = true
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        collectionView.setCollectionViewLayout(layout, animated: false)
        collectionView.register(GenreCollectionViewCell.self, forCellWithReuseIdentifier: GenreCollectionViewCell.identifier)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        return collectionView
    }()
    
    // MARK: - Properties
    
    private var loadedGenres: [Genre] = []
    private var selectedGenres: [Genre] = []
    
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
        self.loadedGenres = genres
    }
    
    func getSelectedGenres() -> [Genre] {
        return selectedGenres
    }
    
    // MARK: - Private Methods
    
    private func selectGenre(_ genre: Genre) {
        selectedGenres.append(genre)
    }
    
    private func deselectGenre(_ genre: Genre) {
        
        for (index, value) in selectedGenres.enumerated() {
            if value.id == genre.id {
                selectedGenres.remove(at: index)
            }
        }
    }
}

// MARK: - Collection View

// delegate

extension GenreView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let genreCell = cell as? GenreCollectionViewCell else {
            return
        }
        
        if genreCell.isSelected {
            genreCell.select()
            return
        }
        
        genreCell.deselect()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? GenreCollectionViewCell else {
            return
        }
        
        let genre = loadedGenres[indexPath.item]
        
        cell.select()
        selectGenre(genre)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? GenreCollectionViewCell else {
            return
        }
        
        let genre = loadedGenres[indexPath.item]
        
        cell.deselect()
        deselectGenre(genre)
    }
}

// data Source

extension GenreView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return loadedGenres.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GenreCollectionViewCell.identifier, for: indexPath) as? GenreCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.setup(with: loadedGenres[indexPath.item].name, and: Colors.yellow)
        
        return cell
    }
}

// delegate flow layout

extension GenreView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
}

// MARK: - View Coding

extension GenreView {
    
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
