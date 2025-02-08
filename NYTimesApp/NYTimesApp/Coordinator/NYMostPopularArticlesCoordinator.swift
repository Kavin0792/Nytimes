//
//  NYMostPopularArticlesCoordinator.swift
//  NYTimesApp
//
//  Created by Kavin on 06/02/25.
//

import Foundation
import UIKit

final class NYMostPopularArticlesCoordinator: NYTimesAppCoordinatorProtocol {
    
    var window: UIWindow
    
    private var localizationService: LocalizationServicableProtocol
    private var networkClientService: NetworkClientProtocol
    
    init(window: UIWindow,
         localizationService: LocalizationServicableProtocol,
         networkClientService: NetworkClientProtocol) {
        self.window = window
        self.localizationService = localizationService
        self.networkClientService = networkClientService
    }
    
    func start() {
        navigateUserToMostPopularArticlesScreen()
    }
    
    func navigateUserToMostPopularArticlesScreen() {
        guard let rootViewController = window.rootViewController as? UINavigationController else { return }
        NYMostPopularListingCoordinator(with: rootViewController,
                                        localizationService: localizationService,
                                        networkClientService: networkClientService,
                                        delegate: self).start()
    }
}

extension NYMostPopularArticlesCoordinator: NYMostPopularListingCoordinatorDelegateProtocol {
    
    func navigateUserTo(article: Article) {
        guard let rootViewController = window.rootViewController as? UINavigationController else { return }
        NYArticlesDetailsCoordinator(with: rootViewController,
                                     localizationService: localizationService,
                                     networkClientService: networkClientService,
                                     article: article).start()
        
    }
}
