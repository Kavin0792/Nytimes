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
        guard let url = URL(string: "https://api.nytimes.com/svc/") else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        switch self {
        case .getMostPopularArticles:
            return "mostpopular/v2/mostviewed/all-sections/30.json"
        }
    }
    
    var httpMethod: HTTPMethod {
            return .get
    }
    
    var task: HTTPTask {
        let requestParameters:[String:Any] = ["api-key" : "eEQGlGPrhiBTQVGH1S1ouxu0h85GsNJo"]
        return .requestParameters(bodyParameters: nil,
                                  bodyEncoding: .urlEncoding,
                                  urlParameters: requestParameters)
    }
}

