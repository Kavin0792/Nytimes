//
//  HTTPTask.swift
//  NYTimesApp
//
//  Created by Kavin on 07/02/25.
//

import Foundation

public typealias HTTPHeaders = [String:String]

public enum HTTPTask {    
    case requestParameters(bodyParameters: Parameters?,
        bodyEncoding: ParameterEncoding,
        urlParameters: Parameters?)

}
