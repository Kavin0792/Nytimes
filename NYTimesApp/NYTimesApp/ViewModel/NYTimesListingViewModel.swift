//
//  NYTimesListingViewModel.swift
//  NYTimesApp
//
//  Created by Kavin on 06/02/25.
//

import Foundation

final class NYTimesListingViewModel: NYTimesListingViewModelProtocol {
    
    var coordinatorDelegate: NYMostPopularListingCoordinatorDelegateProtocol?
    var loaderMsg: String {
        localizationService.localizedStringForKey(key: "loading",
                                                  comment: "loading")
    }
    var screenTitle: String {
        localizationService.localizedStringForKey(key: "listing_title",
                                                  comment: "Title")
    }
    var localizationService: LocalizationServicableProtocol
    var networkClient: NetworkClientProtocol
    var view: NYTimesListingViewProtocol?
    
    private var searchText: String?
    private var articles: [Article]?
    private var filteredArticles: [Article] {
        var displayedArticles = [Article]()
        if searchText != nil {
            displayedArticles = articles?.filter({$0.title!.containsIgnoringCase(searchText!)}) ?? []
        } else {
            displayedArticles = articles ?? []
        }
        ((searchText?.isEmpty) != nil && displayedArticles.isEmpty) ? view?.showNoSearchText() : view?.hideNoSearchText()
        return displayedArticles
    }
    
    init(localizationService: LocalizationServicableProtocol,
         apiClient: NetworkClientProtocol) {
        self.localizationService = localizationService
        networkClient = apiClient
    }
    
    func searchText(_ text: String) {
        searchText = text == "" ?  nil : text
        view?.reloadView()
    }

    func didSelect(row: IndexPath) {
        let article = filteredArticles[row.row]
        coordinatorDelegate?.navigateUserTo(article: article)
    }

    func configure(cell: NYTimesListingCellViewProtocol, forRow row: Int) {
        let article = filteredArticles[row]
        cell.display(title: article.title ?? "")
        cell.display(subTitle: article.source ?? "")
        cell.display(date: article.publishedDate ?? "")
        
        guard let media = article.media?.first else {
            cell.display(imageURL: nil)
            return }

        guard let imageURL = media.mediaMetadata?.first(where: {$0.format == .standardThumbnail})?.url else {
            cell.display(imageURL: nil)
            return }
    
        cell.display(imageURL: URL(string: imageURL))
    }
    
    func numberOfRowsInSection() -> Int {
        filteredArticles.count
    }

    func loadData(completionHandler: @escaping (() -> Void)) {
        view?.showLoader()
        fetchArticle {[weak self] articles in
            self?.articles = articles
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                view?.dismissLoader()
                view?.reloadView()
                completionHandler()
            }
        }
    }
    
    private func fetchArticle(completionHandler: @escaping (([Article]?) -> Void)) {
        networkClient.fetchPopularArticles() {result in
            switch result {
            case .success(let response):
                completionHandler(response.results)
            case .failure(_):
                print("Error")
            }
        }
    }

    func configureView(view: NYTimesListingViewProtocol) {
        self.view = view
    }
}
