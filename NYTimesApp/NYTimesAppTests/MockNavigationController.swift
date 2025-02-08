//
//  MockNavigationController.swift
//  NYTimesApp
//
//  Created by Kavin on 07/02/25.
//

import UIKit

final class MockNavigationController: UINavigationController {
    var pushedViewController: UIViewController?
    var isViewControllerPushed = false
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        pushedViewController = viewController
        super.pushViewController(viewController, animated: animated)
    }
}
