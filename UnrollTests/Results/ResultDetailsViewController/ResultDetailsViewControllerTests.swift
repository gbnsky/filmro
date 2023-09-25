//
//  ResultDetailsViewControllerTests.swift
//  UnrollTests
//
//  Created by Gabriel Garcia on 25/09/23.
//

import XCTest
@testable import Unroll

class ResultDetailsViewControllerTests: XCTestCase {

    // MARK: - Properties
    
    var resultDetailsViewController: ResultDetailsViewController!

    // MARK: - Initializers
    
    override func setUp() {
        super.setUp()
        
        resultDetailsViewController = ResultDetailsViewController()
    }

    override func tearDown() {
        resultDetailsViewController = nil
        super.tearDown()
    }

    // MARK: - Tests
    
    func test_viewDidLoad() {
        
        // Given
        resultDetailsViewController.loadedMovie = getLoadedMovie()
        resultDetailsViewController.loadedWatchProviders = getLoadedWatchProvidersResponse()
        
        // When
        resultDetailsViewController.loadViewIfNeeded()
        
        // Then
        XCTAssertNotNil(resultDetailsViewController.view is ResultDetailsView)
    }
    
    func test_viewDidNotLoad_whenLoadedMovieIsNil() {
        
        // Given
        let view = resultDetailsViewController.view as! ResultDetailsView
        resultDetailsViewController.loadedMovie = nil
        resultDetailsViewController.loadedWatchProviders = getLoadedWatchProvidersResponse()
        
        // When
        resultDetailsViewController.loadViewIfNeeded()
        
        // Then
        XCTAssertEqual(view.movieBackdrop.image, UIImage(named: "placeholder-backdrop"))
        XCTAssertTrue(view.movieTitle.text.isEmpty)
        XCTAssertTrue(view.movieTitle.text.isEmpty)
        XCTAssertTrue(view.movieOriginalTitle.text.isEmpty)
        XCTAssertTrue(view.movieTagline.text.isEmpty)
        XCTAssertTrue(view.movieOverview.text.isEmpty)
    }
}

// MARK: - Helpers

extension ResultDetailsViewControllerTests {
    
    private func getLoadedMovie() -> Movie {
        return Movie(backdropPath: nil,
                     genreIds: [1],
                     id: 1,
                     overview: "Overview 1",
                     posterPath: nil,
                     releaseDate: "10-05-2001",
                     title: "Title 1",
                     originalTitle: "Title 1",
                     originalLanguage: "en",
                     runtime: 120,
                     tagline: "Tagline 1")
    }
    
    private func getLoadedWatchProvidersResponse() -> WatchProvidersResponse {

        let firstWatchProviderResponse = WatchProviderResponse(logoPath: nil,
                                                               providerId: 1,
                                                               providerName: "Provider 1",
                                                               displayPriority: 1)
        
        let secondWatchProviderResponse = WatchProviderResponse(logoPath: nil,
                                                                providerId: 2,
                                                                providerName: "Provider 2",
                                                                displayPriority: 2)
        
        let us = WatchProviderResult(link: nil,
                                     rent: nil,
                                     buy: nil,
                                     flatrate: [firstWatchProviderResponse, secondWatchProviderResponse])
        
        let br = WatchProviderResult(link: nil,
                                     rent: nil,
                                     buy: nil,
                                     flatrate: [secondWatchProviderResponse, firstWatchProviderResponse])
        
        let results = WatchProviderResults(us: us, br: br)
        
        return WatchProvidersResponse(id: 123, results: results)
    }
}

