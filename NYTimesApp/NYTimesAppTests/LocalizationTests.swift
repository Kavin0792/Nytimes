//
//  LocalizationTests.swift
//  NYTimesAppTests
//
//  Created by Kavin on 07/02/25.
//

import XCTest
@testable import NYTimesApp

final class LocalizationTests: XCTestCase {
    
    var localization: LocalizationService!
    
    override func setUp() async throws {
        localization = LocalizationService()
    }
    
    func testTitle() {
        let bundleTitle =  localization.localizedStringForKey(key: "listing_title", comment: "listing_title")
        XCTAssertEqual(bundleTitle, "NY Times Most Popular")
    }
    
}
