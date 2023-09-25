//
//  WatchProviderViewControllerTests.swift
//  UnrollTests
//
//  Created by Gabriel Garcia on 25/09/23.
//

import XCTest
@testable import Unroll

class WatchProviderViewControllerTests: XCTestCase {

    // MARK: - Properties
    
    var watchProviderViewController: WatchProviderViewController!

    // MARK: - Initializers
    
    override func setUp() {
        super.setUp()
        
        watchProviderViewController = WatchProviderViewController()
        watchProviderViewController.loadedWatchProviders = getLoadedWatchProviders()
        watchProviderViewController.loadViewIfNeeded()
    }

    override func tearDown() {
        watchProviderViewController = nil
        super.tearDown()
    }

    // MARK: - Tests
    
    func test_collectionView_cellForItemAt() {
        
        // Given
        let sut = makeSut()
        let indexPath = IndexPath(item: 0, section: 0)
        let expectedNumberOfItems = getLoadedWatchProviders().count

        // When
        let cell = watchProviderViewController.collectionView(sut, cellForItemAt: indexPath)
        let numberOfItems = watchProviderViewController.collectionView(sut, numberOfItemsInSection: 0)
        
        // Then
        XCTAssertEqual(numberOfItems, expectedNumberOfItems)
        XCTAssertTrue(cell is WatchProviderCollectionViewCell)
    }
    
    func test_collectionView_didSelectItemAt() {

        // Given
        let sut = makeSut()
        let indexPath = IndexPath(item: 0, section: 0)
        let expectedSelectedItemsCount = 1

        // When
        watchProviderViewController.collectionView(sut, didSelectItemAt: indexPath)
        let selectedItemsCount = watchProviderViewController.selectedWatchProviders.count

        // Then
        XCTAssertEqual(selectedItemsCount, expectedSelectedItemsCount)
    }

    func test_collectionView_didDeselectItemAt() {

        // Given
        let sut = makeSut()
        let indexPath = IndexPath(item: 0, section: 0)
        let expectedSelectedItemsCount = 1
        watchProviderViewController.selectedWatchProviders = getLoadedWatchProviders()
        
        // When
        watchProviderViewController.collectionView(sut, didDeselectItemAt: indexPath)
        let selectedItemsCount = watchProviderViewController.selectedWatchProviders.count
        
        // Then
        XCTAssertEqual(selectedItemsCount, expectedSelectedItemsCount)
    }

    func test_collectionView_sizeForItemAt() {

        // Given
        let sut = makeSut()
        let expectedSize = CGSize(width: 100, height: 100)

        // When
        let indexPath = IndexPath(item: 0, section: 0)
        let size = watchProviderViewController.collectionView(sut, layout: sut.collectionViewLayout, sizeForItemAt: indexPath)

        // Then
        XCTAssertEqual(size, expectedSize)
    }
    
}

// MARK: - Helpers

extension WatchProviderViewControllerTests {
    
    private func makeSut() -> UICollectionView {
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewLayout())
        collectionView.register(WatchProviderCollectionViewCell.self, forCellWithReuseIdentifier: WatchProviderCollectionViewCell.identifier)
        return collectionView
    }
    
    private func getLoadedWatchProviders() -> [WatchProvider] {
        let firstDisplayPriority = DisplayPriority(us: 2, br: 2)
        let secondDisplayPriority = DisplayPriority(us: 1, br: 1)
        
        let watchProviders = [
            WatchProvider(displayPriorities: firstDisplayPriority,
                          displayPriority: 2,
                          providerName: "Netflix",
                          providerId: 123),
            
            WatchProvider(displayPriorities: secondDisplayPriority,
                          displayPriority: 1,
                          providerName: "Max",
                          providerId: 456)
        ]
        
        return WatchProviders(results: watchProviders).results
    }
}

