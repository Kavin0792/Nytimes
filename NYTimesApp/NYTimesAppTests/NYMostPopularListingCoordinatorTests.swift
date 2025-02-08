//
//  NYMostPopularListingCoordinatorTests.swift
//  NYTimesApp
//
//  Created by Kavin on 07/02/25.
//

import XCTest
@testable import NYTimesApp

final class NYMostPopularListingCoordinatorDelegate: NYMostPopularListingCoordinatorDelegateProtocol {
    func navigateUserTo(article: Article) {
    }
}

final class NYMostPopularListingCoordinatorTests: XCTestCase {
    var coordinator: NYMostPopularListingCoordinator!
    var navigationController: MockNavigationController!
    var delegate: NYMostPopularListingCoordinatorDelegateProtocol?
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        navigationController = MockNavigationController()
        guard let navigationController else { return }
        coordinator = NYMostPopularListingCoordinator(with: navigationController,
                                                      localizationService: LocalizationService(),
                                                      networkClientService: NetworkClientSuccess(),
                                                      delegate: NYMostPopularListingCoordinatorDelegate())
    }
    
    func testNavigation() {
        coordinator.start()
        XCTAssertTrue(navigationController!.pushedViewController is NYTimesListingController)
    }
}
