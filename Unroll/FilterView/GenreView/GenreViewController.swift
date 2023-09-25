//
//  GenreViewController.swift
//  Unroll
//
//  Created by Gabriel Garcia on 23/09/23.
//

import UIKit

// MARK: - Class

class GenreViewController: UIViewController {

    // MARK: - UI Components
    
    private lazy var genreView: GenreView = {
        let view = GenreView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.dataSource = self
        view.delegate = self
        return view
    }()
    
    // MARK: - Properties

    var loadedGenres: [Genre] = []
    var selectedGenres: [Genre] = []
    
    // MARK: - View Lifecycle

    override func loadView() {
        super.loadView()
        view = genreView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchMovieGenres()
    }

    // MARK: - Private Methods

    private func fetchMovieGenres() {
        MovieApi.shared.getMovieGenreList { genres in
            self.setFetchedGenres(with: genres)
        }
    }

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
    
    private func setFetchedGenres(with genres: [Genre]?) {
        guard let genres = genres else {
            return
        }
        loadedGenres = genres
        genreView.reloadCollectionViewData()
    }
}

// MARK: - Collection View Delegate and DataSource

extension GenreViewController: UICollectionViewDelegate, UICollectionViewDataSource {

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

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let genre = loadedGenres[indexPath.item]
        selectGenre(genre)
    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let genre = loadedGenres[indexPath.item]
        deselectGenre(genre)
    }
}

// MARK: - Collection View Delegate Flow Layout

extension GenreViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
}
