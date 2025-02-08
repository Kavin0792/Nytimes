//
//  APINYTimesFetcher.swift
//  NYTimesApp
//
//  Created by Kavin on 07/02/25.
//

import Foundation

protocol NetworkClientProtocol {
    func fetchPopularArticles(completionHandler: @escaping (Result<NYTimesArticlsListResponse, Errors>) -> Void)
}

final class NetworkClient : NetworkClientProtocol, NetworkParser {
    
    var networkManager: NetworkManagerProtocol!
    private let parseError = "Response Object cannot be parsed"
    private let someError = "Something went wrong"
    
    init(networkManager: NetworkManagerProtocol = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func fetchPopularArticles(completionHandler: @escaping (Result<NYTimesArticlsListResponse, Errors>) -> Void){
        networkManager.fetch(request: .getMostPopularArticles){  data, error in
            if let error = error {
                completionHandler(.failure(Errors.apiError(error: error)))
                return
            } else if let dd = data , !dd.isEmpty {
                do {
                    completionHandler(.success(try self.decode(dd)))
                } catch {
                    completionHandler(.failure(Errors.badResponse))
                }
            } else {
                completionHandler(.failure(Errors.badResponse))
            }
        }
    }
}
