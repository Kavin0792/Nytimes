//
//  NYArticlesDetailsViewModelTests.swift
//  NYTimesApp
//
//  Created by Kavin on 07/02/25.
//

import XCTest
@testable import NYTimesApp

final class NYArticlesDetailsViewModelTests: XCTestCase {
    
    func testArticleDetails() {
        // Given
        guard let article =  NetworkClientSuccess().loadJson(filename: "PopularArticlesResponse")?.results?.first else { return }
        
        //When
        let model = NYArticlesDetailsViewModel(localizationService: LocalizationService(), apiClient: NetworkClientSuccess(), article: article)
        let media = article.media?.first
        let imageURL = media?.mediaMetadata?.first(where: {$0.format == .mediumThreeByTwo440})?.url
        
        // Then
        XCTAssertEqual(model.articleTitle, article.title)
        XCTAssertEqual(model.articleSource, article.source)
        XCTAssertEqual(model.articleSubTitle, article.subsection)
        XCTAssertEqual(model.articlePublishedOn, article.publishedDate)
        XCTAssertEqual(model.articleUpdatedOn, article.updated)
        guard let imageURL = URL(string: imageURL!) else {
            XCTAssertFalse(true)
            return
        }
        XCTAssertEqual(model.articleImageURL, imageURL)
    }
}
