//
//  NYTimesEndPoint.swift
//  NYTimesApp
//
//  Created by Kavin on 07/02/25.
//

import Foundation

final class GetMostPopularArticles: EndPointType {
    
    var baseURL: URL {
        URL(string: URLConstant.baseURL)!
    }
    
    var path: String {
        URLConstant.getMostPopularArticles
    }
    
    var httpMethod: HTTPMethod { .get }
    
    var task: HTTPTask {
        
        let apiKey = Bundle.main.object(
                    forInfoDictionaryKey: "API_KEY"
                )!
    
        let requestParameters: [String:Any] = ["api-key" : apiKey]
        return .requestParameters(bodyParameters: nil,
                                  bodyEncoding: .urlEncoding,
                                  urlParameters: requestParameters)
    }
}
