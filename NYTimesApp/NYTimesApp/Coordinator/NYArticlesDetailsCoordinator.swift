//
//  NYArticlesDetailsCoordinator.swift
//  NYTimesApp
//
//  Created by Kavin on 07/02/25.
//

import Foundation
import UIKit

final class NYArticlesDetailsCoordinator {
    
    var localizationService: LocalizationServicableProtocol
    var networkClientService: NetworkClientProtocol
    var navigationController: UINavigationController
    var article: Article
    
    init(with navigationController: UINavigationController,
         localizationService: LocalizationServicableProtocol,
         networkClientService: NetworkClientProtocol, article: Article) {
        self.navigationController = navigationController
        self.localizationService = localizationService
        self.networkClientService = networkClientService
        self.article = article
    }
    
    func start() {
        showDetailsScreen()
    }
    
    func showDetailsScreen() {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let view = storyboard.instantiateViewController(identifier: "NYTimesDetailsController", creator: { coder -> NYTimesDetailsController? in
            let viewModel = NYArticlesDetailsViewModel(localizationService: self.localizationService,
                                                       apiClient: self.networkClientService,
                                                       article: self.article)
            return NYTimesDetailsController(coder: coder,
                                            viewModel: viewModel)
        })
        navigationController.pushViewController(view,
                                                animated: true)
    }
}

