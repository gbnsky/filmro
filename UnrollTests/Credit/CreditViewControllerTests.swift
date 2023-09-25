//
//  CreditViewControllerTests.swift
//  UnrollTests
//
//  Created by Gabriel Garcia on 25/09/23.
//

import XCTest
@testable import Unroll

class CreditViewControllerTests: XCTestCase {

    // MARK: - Properties
    
    var creditViewController: CreditViewController!

    // MARK: - Initializers
    
    override func setUp() {
        super.setUp()
        
        creditViewController = CreditViewController()
    }

    override func tearDown() {
        creditViewController = nil
        super.tearDown()
    }

    // MARK: - Tests
    
    func test_viewDidLoad() {

        // When
        creditViewController.loadViewIfNeeded()
        
        // Then
        XCTAssertTrue(creditViewController.view is CreditView)
    }
}
