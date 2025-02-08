//
//  NYMostPopularListingCoordinator.swift
//  NYTimesApp
//
//  Created by Kavin on 06/02/25.
//

import Foundation
import UIKit

protocol NYMostPopularListingCoordinatorDelegateProtocol: AnyObject {
    func navigateUserTo(article: Article)
}

protocol NYMostPopularListingCoordinatorProtocol: AnyObject {
    var delegate: NYMostPopularListingCoordinatorDelegateProtocol { get set }
    var localizationService: LocalizationServicableProtocol { get set }
    var networkClientService: NetworkClientProtocol { get set }
    var navigationController: UINavigationController { get set }
}

final class NYMostPopularListingCoordinator: NYMostPopularListingCoordinatorProtocol {
    
    var delegate: NYMostPopularListingCoordinatorDelegateProtocol
    var localizationService: LocalizationServicableProtocol
    var networkClientService: NetworkClientProtocol
    var navigationController: UINavigationController
    
    init(with navigationController: UINavigationController,
         localizationService: LocalizationServicableProtocol,
         networkClientService: NetworkClientProtocol,
         delegate:  NYMostPopularListingCoordinatorDelegateProtocol) {
        self.navigationController = navigationController
        self.localizationService = localizationService
        self.networkClientService = networkClientService
        self.delegate = delegate
    }
    
    func start() {
        showListingScreen()
    }
    
    private func showListingScreen() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let view = storyboard.instantiateViewController(identifier: "NYTimesListingController", creator: { coder -> NYTimesListingController? in
            let viewModel = NYTimesListingViewModel(localizationService: self.localizationService,
                                                    apiClient: self.networkClientService)
            viewModel.coordinatorDelegate = self.delegate
            return NYTimesListingController(coder: coder,
                                            viewModel: viewModel)
        })
        
        navigationController.pushViewController(view, animated: false)
    }
}
