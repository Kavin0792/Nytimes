//
//  NYTimesEndPoint.swift
//  NYTimesApp
//
//  Created by Kavin on 07/02/25.
//

import Foundation

public enum NYTimesEndPoint {
    case getMostPopularArticles
}

extension NYTimesEndPoint: EndPointType {
    
    var baseURL: URL {
        guard let url = URL(string: URLConstant.baseURL) else {
            fatalError("baseURL could not be configured.")
        }
        return url
    }
    
    var path: String {
        switch self {
        case .getMostPopularArticles:
            URLConstant.getMostPopularArticles
        }
    }
    
    var httpMethod: HTTPMethod {
            .get
    }
    
    var task: HTTPTask {
        let requestParameters: [String:Any] = ["api-key" : Constant.apiKey]
        return .requestParameters(bodyParameters: nil,
                                  bodyEncoding: .urlEncoding,
                                  urlParameters: requestParameters)
    }
}

