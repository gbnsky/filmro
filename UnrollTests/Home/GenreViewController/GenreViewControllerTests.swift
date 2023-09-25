//
//  GenreViewControllerTests.swift
//  UnrollTests
//
//  Created by Gabriel Garcia on 23/09/23.
//

import XCTest
@testable import Unroll

class GenreViewControllerTests: XCTestCase {

    // MARK: - Properties
    
    var genreViewController: GenreViewController!

    // MARK: - Initializers
    
    override func setUp() {
        super.setUp()
        
        genreViewController = GenreViewController()
        genreViewController.loadedGenres = getLoadedGenres()
        genreViewController.loadViewIfNeeded()
    }

    override func tearDown() {
        genreViewController = nil
        super.tearDown()
    }

    // MARK: - Tests
    
    func 
    
    func test_collectionView_cellForItemAt() {
        
        // Given
        let sut = makeSut()
        let indexPath = IndexPath(item: 0, section: 0)
        let expectedNumberOfItems = getLoadedGenres().count
        let numberOfItems = genreViewController.collectionView(sut, numberOfItemsInSection: 0)

        // When
        let cell = genreViewController.collectionView(sut, cellForItemAt: indexPath)
        
        // Then
        XCTAssertEqual(numberOfItems, expectedNumberOfItems)
        XCTAssertTrue(cell is GenreCollectionViewCell)
    }
    
    func test_collectionView_didSelectItemAt() {
        
        // Given
        let sut = makeSut()
        let indexPath = IndexPath(item: 0, section: 0)

        // When
        genreViewController.collectionView(sut, didSelectItemAt: indexPath)
        
        // Then
        XCTAssertEqual(genreViewController.selectedGenres.count, 1)
    }
    
    func test_collectionView_didDeselectItemAt() {
        
        // Given
        let sut = makeSut()
        let indexPath = IndexPath(item: 0, section: 0)
        genreViewController.selectedGenres = getLoadedGenres()
        
        // When
        genreViewController.collectionView(sut, didDeselectItemAt: indexPath)
        
        // Then
        XCTAssertEqual(genreViewController.selectedGenres.count, 1)
    }
    
    func test_collectionView_sizeForItemAt() {
        
        // Given
        let sut = makeSut()

        // When
        let indexPath = IndexPath(item: 0, section: 0)
        let size = genreViewController.collectionView(sut, layout: sut.collectionViewLayout, sizeForItemAt: indexPath)

        // Then
        XCTAssertEqual(size, CGSize(width: 100, height: 100))
    }
}

// MARK: - Helpers

extension GenreViewControllerTests {
    
    private func makeSut() -> UICollectionView {
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewLayout())
        collectionView.register(GenreCollectionViewCell.self, forCellWithReuseIdentifier: GenreCollectionViewCell.identifier)
        return collectionView
    }
    
    private func getLoadedGenres() -> [Genre] {
        return [Genre(id: 1, name: "Action"), Genre(id: 2, name: "Adventure")]
    }
}

