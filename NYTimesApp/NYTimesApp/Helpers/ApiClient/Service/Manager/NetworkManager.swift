//
//  NetworkManager.swift
//  NYTimesApp
//
//  Created by Kavin on 07/02/25.
//

import Foundation

enum NetworkResponse:String {
    case success
    case authenticationError = "Something went wrong"
    case badRequest = "Bad request"
    case outdated = "The url you requested is outdated."
    case failed = "Network request failed."
    case noData = "Response returned with no data to decode."
    case unableToDecode = "We could not decode the response."
    case notReachable = "Please check your internet connection"
    case networkLost = "Network connection lost"
    case userLoggedInError = "User loggedin Error"
    case requestTimeout = "Request Timeout!!"
}

enum NetworkResult<String>{
    case success
    case failure(String)
}

protocol NetworkManagerProtocol {
    func fetch(request: EndPointType,
               completion: @escaping (_ data: Data?,
                                      _ error: String?) ->())
}

struct NetworkManager: NetworkManagerProtocol {
    
    let router = Router()
   
    func fetch(request: EndPointType,
               completion: @escaping (_ data: Data?,
                                      _ error: String?) ->()) {
        let reachability = try! Reachability()
        if reachability.connection == .unavailable {
            completion(nil, NetworkResponse.notReachable.rawValue)
        }
        else {
            router.request(request) { (data, response, error) in
                if error != nil {
                    print("responseJSON = \(error.debugDescription)")
                    if let error = error {
                        if error._code == NSURLErrorTimedOut {
                            completion(nil, "Request Timeout!!")
                            return
                        }
                        if error._code == NSURLErrorNetworkConnectionLost || error._code == NSURLErrorDataNotAllowed  {
                            completion(nil, NetworkResponse.notReachable.rawValue)
                            return
                        }
                        completion(nil, error.localizedDescription)
                        return
                    }
                    completion(nil, error.debugDescription)
                }
                if let response = response as? HTTPURLResponse {
                    print("Requested URL = \(response.url?.absoluteString ?? "")")
                    
                    let result = self.handleNetworkResponse(response)
                    
                    switch result {
                    case .success:
                        guard let responseData = data else {
                            completion(nil, NetworkResponse.noData.rawValue)
                            return
                        }
                        
                        
                        let responseJSON = String(decoding: responseData, as: UTF8.self)
                        print("responseJSON = \(responseJSON)")
                        
                        completion(responseData,nil)
                        
                    case .failure(let networkFailureError):
                        guard let responseData = data else {
                            completion(nil, networkFailureError)
                            return
                        }
                        
                        do {
                            let json = try JSONSerialization.jsonObject(with: responseData, options: [])
                            if let object = json as? [String: Any] {
                                // json is a dictionary
                                if object["UIMessage"] != nil {
                                    completion(nil,object["UIMessage"] as? String)
                                }
                                else {
                                    completion(nil, networkFailureError)
                                }
                                print(object)
                            }
                            else {
                                completion(nil, networkFailureError)
                            }
                        }
                        catch {
                            completion(nil, "Something went wrong")
                        }
                    }
                }}
        }
    }
    
    fileprivate func handleNetworkResponse(_ response: HTTPURLResponse) -> NetworkResult<String>{
        
        switch response.statusCode {
            
        case 200...299: return .success
        case 401...500: return .failure(NetworkResponse.authenticationError.rawValue)
        case 501...599: return .failure(NetworkResponse.badRequest.rawValue)
        case 600: return .failure(NetworkResponse.outdated.rawValue)
        default: return .failure(NetworkResponse.failed.rawValue)
        }
    }
    
}
