//
//  SortByViewControllerTests.swift
//  UnrollTests
//
//  Created by Gabriel Garcia on 25/09/23.
//

import XCTest
@testable import Unroll

class SortByViewControllerTests: XCTestCase {

    // MARK: - Properties
    
    var sortByViewController: SortByViewController!

    // MARK: - Initializers
    
    override func setUp() {
        super.setUp()
        
        sortByViewController = SortByViewController()
        sortByViewController.loadViewIfNeeded()
    }

    override func tearDown() {
        sortByViewController = nil
        super.tearDown()
    }

    // MARK: - Tests
    
    func test_collectionView_cellForItemAt() {
        
        // Given
        let sut = makeSut()
        let indexPath = IndexPath(item: 0, section: 0)
        let expectedCellCount = SortBy.allCases.count
        let expectedCellTitle = SortBy.allCases[indexPath.item].title

        // When
        let cell = sortByViewController.collectionView(sut, cellForItemAt: indexPath) as! SortByCollectionViewCell
        let cellCount = sortByViewController.collectionView(sut, numberOfItemsInSection: 0)
        let cellTitle = cell.title.text
        
        // Then
        XCTAssertEqual(cellCount, expectedCellCount)
        XCTAssertEqual(cellTitle, expectedCellTitle)
    }
    
    func test_collectionView_didSelectItemAt() {

        // Given
        let sut = makeSut()
        let indexPath = IndexPath(item: 1, section: 0)
        let expectedSelectedSort = SortBy.allCases[indexPath.item]

        // When
        sortByViewController.collectionView(sut, didSelectItemAt: indexPath)
        let selectedSort = sortByViewController.selectedSortBy

        // Then
        XCTAssertEqual(selectedSort, expectedSelectedSort)
    }

    func test_collectionView_sizeForItemAt() {

        // Given
        let sut = makeSut()
        let expectedSize = CGSize(width: 100, height: 100)

        // When
        let indexPath = IndexPath(item: 0, section: 0)
        let size = sortByViewController.collectionView(sut, layout: sut.collectionViewLayout, sizeForItemAt: indexPath)

        // Then
        XCTAssertEqual(size, expectedSize)
    }
}

// MARK: - Helpers

extension SortByViewControllerTests {
    
    private func makeSut() -> UICollectionView {
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewLayout())
        collectionView.register(SortByCollectionViewCell.self, forCellWithReuseIdentifier: SortByCollectionViewCell.identifier)
        return collectionView
    }
}

