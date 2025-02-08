//
//  NYTimesDetailViewModelTests.swift
//  NYTimesApp
//
//  Created by Kavin on 07/02/25.
//

import XCTest
@testable import NYTimesApp

final class NYTimesDetailCoordinatotTests: XCTestCase {
    var coordinator: NYArticlesDetailsCoordinator!
    var navigationController: MockNavigationController!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        navigationController = MockNavigationController()
        guard let navigationController else { return }
        
        guard let article =  NetworkClientSuccess().loadJson(filename: "PopularArticlesResponse")?.results?.first else { return }
        
        coordinator = NYArticlesDetailsCoordinator(with: navigationController, localizationService: LocalizationService(), networkClientService: NetworkClientSuccess(), article: article)
    }
    
    func testNavigation() {
        coordinator.start()
        XCTAssertTrue(navigationController!.pushedViewController is NYTimesDetailsController)
    }
}
