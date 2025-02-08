//
//  NYArticlesDetailsViewModel.swift
//  NYTimesApp
//
//  Created by Kavin on 07/02/25.
//

import Foundation

final class NYArticlesDetailsViewModel: NYArticlesDetailsViewModelProtocol {
    var articleTitle: String { article.title.notNil }
    var articleSubTitle: String { article.subsection.notNil }
    var articlePublishedOn: String { article.publishedDate.notNil }
    var articleUpdatedOn: String { article.updated.notNil }
    var articleSource: String { article.source.notNil }
    
    private var localizationService: LocalizationServicableProtocol
    private var networkClient: NetworkClientProtocol
    private var article: Article

    var articleImageURL: URL? {
        guard let media = article.media?.first else { return nil }
        guard let imageURL = media.mediaMetadata?.first(where: {$0.format == .mediumThreeByTwo440})?.url else { return nil }
        return URL(string: imageURL)
    }

    init(localizationService: LocalizationServicableProtocol,
         apiClient: NetworkClientProtocol,
         article: Article) {
        self.localizationService = localizationService
        self.article = article
        networkClient = apiClient
    }
}
