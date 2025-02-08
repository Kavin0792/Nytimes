//
//  NetworkParser.swift
//  NYTimesApp
//
//  Created by Kavin on 07/02/25.
//

import Foundation

protocol NetworkParser {
    
    func decode<ResultType: Decodable>(_ response: Data) throws -> ResultType
}

extension NetworkParser {
    
    func decode<ResultType: Decodable>(_ response: Data) throws -> ResultType {
        do {
            return try JSONDecoder.shared.decode(ResultType.self, from: response)
        } catch {
           print(error)
        }
        return try JSONDecoder.shared.decode(ResultType.self, from: response)
    }
}

extension JSONDecoder {
    
    static let shared = JSONDecoder()
}
