//
//  Router.swift
//  NYTimesApp
//
//  Created by Kavin on 07/02/25.
//

import Foundation

public typealias NetworkRouterCompletion = (_ data: Data?,_ response: URLResponse?,_ error: Error?)->()

protocol NetworkRouter: AnyObject {
    func request(_ route: EndPointType, completion: @escaping NetworkRouterCompletion)
    func cancel()
}

class Router: NetworkRouter {
    private var task: URLSessionTask?

    func request(_ route: EndPointType, completion: @escaping NetworkRouterCompletion) {
        let session = URLSession.shared
        do {
            if let request = try self.buildRequest(from: route) {
                task = session.dataTask(with: request, completionHandler: { data, response, error in
                    completion(data, response, error)
                })
            }
        } catch {
            completion(nil, nil, error)
        }
        self.task?.resume()
    }
    
    func cancel() {
        self.task?.cancel()
    }
    
    fileprivate func buildRequest(from route: EndPointType) throws -> URLRequest? {
        
        var url = URL(string: "")
        url = route.baseURL.appendingPathComponent(route.path)
        
        guard let url else { return nil }
 
        var request = URLRequest(url: url,
                                 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                 timeoutInterval: 10.0)
        request.httpMethod = route.httpMethod.rawValue
        do {
            switch route.task {
            case .requestParameters(let bodyParameters,
                                    let bodyEncoding,
                                    let urlParameters):
                
                try self.configureParameters(bodyParameters: bodyParameters,
                                             bodyEncoding: bodyEncoding,
                                             urlParameters: urlParameters,
                                             request: &request)
                
                
            }
            return request
        } catch {
            throw error
        }
    }
    
    fileprivate func configureParameters(bodyParameters: Parameters?,
                                         bodyEncoding: ParameterEncoding,
                                         urlParameters: Parameters?,
                                         request: inout URLRequest) throws {
        do {
            try bodyEncoding.encode(urlRequest: &request,
                                    bodyParameters: bodyParameters,
                                    urlParameters: urlParameters)
        } catch {
            throw error
        }
    }
}
