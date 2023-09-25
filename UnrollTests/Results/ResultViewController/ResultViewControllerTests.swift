//
//  ResultViewControllerTests.swift
//  UnrollTests
//
//  Created by Gabriel Garcia on 25/09/23.
//

import XCTest
@testable import Unroll

class ResultViewControllerTests: XCTestCase {

    // MARK: - Properties
    
    var resultViewController: ResultViewController!

    // MARK: - Initializers
    
    override func setUp() {
        super.setUp()
        
        resultViewController = ResultViewController()
        resultViewController.loadedMovies = getLoadedMovies()
        resultViewController.loadViewIfNeeded()
    }

    override func tearDown() {
        resultViewController = nil
        super.tearDown()
    }

    // MARK: - Tests
    
    func test_collectionView_cellForItemAt() {
        
        // Given
        let sut = makeSut()
        let indexPath = IndexPath(item: 0, section: 0)
        let expectedNumberOfItems = getLoadedMovies().count
        let numberOfItems = resultViewController.collectionView(sut, numberOfItemsInSection: 0)

        // When
        let cell = resultViewController.collectionView(sut, cellForItemAt: indexPath)
        
        // Then
        XCTAssertEqual(numberOfItems, expectedNumberOfItems)
        XCTAssertTrue(cell is ResultCollectionViewCell)
    }
    
    func test_collectionView_sizeForItemAt() {
        
        // Given
        let sut = makeSut()
        let expectedSize = CGSize(width: resultViewController.view.frame.width, height: resultViewController.view.frame.width)

        // When
        let indexPath = IndexPath(item: 0, section: 0)
        let size = resultViewController.collectionView(sut, layout: sut.collectionViewLayout, sizeForItemAt: indexPath)

        // Then
        XCTAssertEqual(size, expectedSize)
    }
}

// MARK: - Helpers

extension ResultViewControllerTests {
    
    private func makeSut() -> UICollectionView {
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewLayout())
        collectionView.register(ResultCollectionViewCell.self, forCellWithReuseIdentifier: ResultCollectionViewCell.identifier)
        return collectionView
    }
    
    private func getLoadedMovies() -> [Movie] {
        return [Movie(backdropPath: nil,
                      genreIds: [1],
                      id: 1,
                      overview: "Overview 1",
                      posterPath: nil,
                      releaseDate: "10-05-2001",
                      title: "Title 1",
                      originalTitle: "Title 1",
                      originalLanguage: "en",
                      runtime: 120,
                      tagline: "Tagline 1"),
                
                Movie(backdropPath: nil,
                      genreIds: [2, 3],
                      id: 2,
                      overview: "Overview 2",
                      posterPath: nil,
                      releaseDate: "21-10-2009",
                      title: "Title 2",
                      originalTitle: "Título 2",
                      originalLanguage: "pt",
                      runtime: 100,
                      tagline: "Tagline 2")]
    }
}
