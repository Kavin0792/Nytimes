//
//  NYArticlesDetailsViewModelProtocol.swift
//  NYTimesApp
//
//  Created by Kavin on 07/02/25.
//

import UIKit

protocol  NYArticlesDetailsViewModelProtocol {
    
    var articleTitle: String { get }
    var articleSubTitle: String { get }
    var articleImageURL: URL? { get }
    var articlePublishedOn: String { get }
    var articleUpdatedOn: String { get }
    var articleSource: String { get }
    
}

