//
//  EndPointType.swift
//  NYTimesApp
//
//  Created by Kavin on 07/02/25.
//

import Foundation

protocol EndPointType {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
}
