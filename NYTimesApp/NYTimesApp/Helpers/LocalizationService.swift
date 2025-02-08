//
//  LocalizationService.swift
//  NYTimesApp
//
//  Created by Kavin on 06/02/25.
//

import Foundation
import UIKit

final class LocalizationService: LocalizationServicableProtocol {
    
    private var bundle: Bundle = Bundle.main
    
    func localizedStringForKey(key: String, comment: String) -> String {
        bundle.localizedString(forKey: key, value: comment, table: nil)
    }
}
