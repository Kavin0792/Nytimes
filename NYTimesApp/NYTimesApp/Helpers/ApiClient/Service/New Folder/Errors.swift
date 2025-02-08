//
//  Errors.swift
//  NYTimesApp
//
//  Created by Kavin on 07/02/25.
//

import Foundation

enum Errors: Error {
    case apiError(error: String)
    case serverError(statusCode: Int)
    case badResponse
    case parseError(error: String)
    case somethingWrong(error: String)
    case describedError(data: Data)
    case networkError(error: String)
    case loggedINError
}

public enum NetworkError : String, Error {
    case parametersNil = "Parameters were nil."
    case encodingFailed = "Parameter encoding failed."
    case missingURL = "URL is nil."
}
