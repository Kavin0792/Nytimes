//
//  SceneDelegate.swift
//  NYTimesApp
//
//  Created by Kavin on 06/02/25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    private var appCoordinator: AppCoordinator!
    private let localizationService = LocalizationService()
    private let apiClient: NetworkClientProtocol = NetworkClient()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = UINavigationController()
        window?.makeKeyAndVisible()
        
        guard let window else { return }
        appCoordinator = AppCoordinator(window: window,
                                        localizationService: localizationService,
                                        networkClientService: apiClient)
        appCoordinator.start()
    }
}

