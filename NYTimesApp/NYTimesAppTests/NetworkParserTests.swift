//
//  NetworkParserTests.swift
//  NYTimesApp
//
//  Created by Kavin on 07/02/25.
//

import XCTest
@testable import NYTimesApp

final class NetworkParserTests: XCTestCase {
    
    var sut: NYTimesListingViewModel!
    
    override func setUp() {
        super.setUp()
        sut = NYTimesListingViewModel(localizationService: LocalizationService(), apiClient: NetworkClient())
    }
    
    func testData() {
        // Given
        let expectation = XCTestExpectation(description: "Listing api call")
        
        //When
        sut.loadData {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
        
        //Then
        XCTAssertGreaterThan(sut.numberOfRowsInSection(), 0)
    }
}
