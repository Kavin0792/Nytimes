//
//  AppCoordinator.swift
//  NYTimesApp
//
//  Created by Kavin on 06/02/25.
//

import Foundation
import UIKit

final class AppCoordinator: NYTimesAppCoordinatorProtocol {
    
    private var currentCoordinator: NYTimesAppCoordinatorProtocol?
    private var localizationService: LocalizationServicableProtocol
    private var networkClientService: NetworkClientProtocol
    
    var window: UIWindow
    
    init(window: UIWindow,
         localizationService: LocalizationServicableProtocol,
         networkClientService: NetworkClientProtocol) {
        self.window = window
        self.localizationService = localizationService
        self.networkClientService = networkClientService
    }
    
    func start() {
        executeMostPopularListing()
        currentCoordinator?.start()
    }
    
    private func executeMostPopularListing() {
        currentCoordinator = NYMostPopularArticlesCoordinator(window: window, localizationService: localizationService, networkClientService: networkClientService)
    }
}
