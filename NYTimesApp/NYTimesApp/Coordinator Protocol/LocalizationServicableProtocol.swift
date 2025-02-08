//
//  LocalizationServicableProtocol.swift
//  NYTimesApp
//
//  Created by Kavin on 06/02/25.
//

import Foundation

protocol LocalizationServicableProtocol {
    func localizedStringForKey(key:String, comment: String) -> String
}
