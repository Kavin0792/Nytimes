//
//  AppCoordinatorProtocol.swift
//  NYTimesApp
//
//  Created by Kavin on 06/02/25.
//
import Foundation
import UIKit

protocol NYTimesAppCoordinatorProtocol: AnyObject{
    var window: UIWindow {
        get set
    }
    func start()
}
