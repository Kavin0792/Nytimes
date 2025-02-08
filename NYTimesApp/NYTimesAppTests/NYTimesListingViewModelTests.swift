//
//  NYTimesListingViewModelTests.swift
//  NYTimesApp
//
//  Created by Kavin on 07/02/25.
//

import XCTest
@testable import NYTimesApp

final class NYTimesListingCoordinatorSpy: NYMostPopularListingCoordinatorProtocol {
    var delegate: NYMostPopularListingCoordinatorDelegateProtocol
    
    var localizationService: LocalizationServicableProtocol
    
    var networkClientService: NetworkClientProtocol
    
    var navigationController: UINavigationController
    
    init(delegate: NYMostPopularListingCoordinatorDelegateProtocol,
         localizationService: LocalizationServicableProtocol,
         networkClientService: NetworkClientProtocol,
         navigationController: UINavigationController) {
        self.delegate = delegate
        self.localizationService = localizationService
        self.networkClientService = networkClientService
        self.navigationController = navigationController
    }
}

final class NetworkClientFailed: NetworkClientProtocol {
    func fetchPopularArticles(completionHandler: @escaping (Result<NYTimesArticlsListResponse, Errors>) -> Void) {
        completionHandler(.failure(Errors.badResponse))
    }
}

final class NetworkClientSuccess: NetworkClientProtocol {
    
    func loadJson(filename fileName: String) -> NYTimesArticlsListResponse? {
        guard let fileURL = Bundle(for: type(of: self)).url(forResource: fileName, withExtension:"json") else {
                fatalError("File not found")
        }
        
        do {
            let data = try Data(contentsOf: fileURL)
            let decoder = JSONDecoder()
            let jsonData = try decoder.decode(NYTimesArticlsListResponse.self, from: data)
            return jsonData
        } catch {
            print("error:\(error)")
        }
        return nil
    }
    
    func fetchPopularArticles(completionHandler: @escaping (Result<NYTimesApp.NYTimesArticlsListResponse, NYTimesApp.Errors>) -> Void) {
        guard let data = loadJson(filename: "PopularArticlesResponse") else { return }
        completionHandler(.success(data))
    }
}

final class NYTimesListingViewModelTests: XCTestCase {
    
    var sut: NYTimesListingViewModel!
    var stub: NetworkClientProtocol!
    var spy: NYMostPopularListingCoordinatorProtocol!
    
    override func setUp() {
        super.setUp()
        sut = NYTimesListingViewModel(localizationService: LocalizationService(), apiClient: NetworkClientSuccess())
        sut.loadData { }
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testScreenTitle() {
        XCTAssertEqual(sut.screenTitle, "NY Times Most Popular")
    }
    
    func testLoaderMsg() {
        XCTAssertEqual(sut.loaderMsg, "loading")
    }
    
    func testApi() {
        let initialData = sut.numberOfRowsInSection()
        XCTAssertNotEqual(initialData, 0)
    }
    
    func testSearchFunctionality() {
        // Given
        guard let articles =  NetworkClientSuccess().loadJson(filename: "PopularArticlesResponse")?.results else { return }
        
        // When
        sut.searchText("tat")
        let filteredArticleCount = articles.filter({$0.title!.containsIgnoringCase("tat")}).count
        
        // Then
        XCTAssertEqual(filteredArticleCount, sut.numberOfRowsInSection())
    }
    
    func testSearchCancelFunctionality() {
        // Given
        guard let articles =  NetworkClientSuccess().loadJson(filename: "PopularArticlesResponse")?.results else { return }
        let initialCount = articles.count
        
        // When
        sut.searchText("tat")
        sut.searchText("")
        let currentCount = sut.numberOfRowsInSection()
        
        // Then
        XCTAssertEqual(currentCount, initialCount)
    }
}


final class NYTimesListingViewModelFailedTests: XCTestCase {
    
    var sut: NYTimesListingViewModel!
    var stub: NetworkClientProtocol!
    var spy: NYMostPopularListingCoordinatorProtocol!
    
    override func setUp() {
        super.setUp()
        sut = NYTimesListingViewModel(localizationService: LocalizationService(),
                                      apiClient: NetworkClientFailed())
    }
    
    func testFailure() {
        // Given
        let expectation = XCTestExpectation(description: "Listing api call")
        
        //When
        sut.loadData {
            expectation.fulfill()
        }
        let result = XCTWaiter.wait(for: [expectation], timeout: 10.0)
        
        //Then
        if result == XCTWaiter.Result.timedOut {
            XCTAssertTrue(true)
        } else {
            XCTAssertTrue(false)
        }
    }
}
