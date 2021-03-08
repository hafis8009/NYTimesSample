//
//  NetworkClient.swift
//  GScent
//
//  Created by Hafiz Abdul kareem on 05/03/2021.
//  Copyright © 2021 Hafiz. All rights reserved.
//

import Foundation

typealias Headers = [String: Any]
typealias NetworkCompletionBlock = (_ response: Any?, _ headers: Headers?, _ error: CoreError?) -> Void
typealias Parameters = [String: String]
typealias JSONDictionary = [AnyHashable: Any]
typealias JSONArray = [Any]

protocol NetworkClientAdaptable {
    func sendRequest(withRequestBody requestBody: String?,
                     requestHeaders: Headers,
                     queryParameters: Parameters,
                     completionHandler: @escaping NetworkCompletionBlock)
}

class NetworkClient: NetworkClientAdaptable {
    private let endpoint: NetworkEndpointModel
    private(set) var reachablity: ReachabilityAdapter
    
    init(endpoint: NetworkEndpointModel,
         reachablity: ReachabilityAdapter = Reachability()!) {
        self.endpoint = endpoint
        self.reachablity = reachablity
    }
    
    func sendRequest(withRequestBody requestBody: String?,
                     requestHeaders: Headers,
                     queryParameters: Parameters,
                     completionHandler: @escaping NetworkCompletionBlock) {
        if let url = try? endpoint.asURLRequest() {
            let session = URLSession.shared
            session.configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
             
            guard let querryItems = defaultQueries.toURLQuerryItems(), let finalUrl = url.url!.url(with: querryItems) else {
                 completionHandler(nil, nil, CoreError(type: .invalidRequestFormat))
                 return
            }
             
            let task = session.dataTask(with: finalUrl) { data, _, error in
                if let error = error {
                    completionHandler(nil, nil, CoreError(error: error))
                    return
                }
                completionHandler(data, nil, nil)
            }
            task.resume()
        }else if let fileName = endpoint.offlineFileName, !fileName.isEmpty {
            loadOfflineData(completionHandler: completionHandler)
        }else {
            completionHandler(nil, nil, CoreError(type: .invalidRequestFormat))
            return
        }
    }
}

extension NetworkClient {
    private func loadOfflineData(completionHandler: @escaping NetworkCompletionBlock) {
        let jsonData = JSONHelper.wrappedJSONFileToDataAndHttpStatus(jsonName: endpoint.offlineFileName!)
        
        var error: CoreError?
        if let statusCode = jsonData.httpStatus, !(200...299).contains(statusCode) {
            error = CoreError(type: .serverError)
            completionHandler(nil, nil, error)
            return
        }
        
        guard let data = jsonData.data else {
            completionHandler(nil, nil, CoreError(type: .serverError))
            return
        }
        
        completionHandler(data, nil, nil)
    }
}

extension NetworkClient {
    var defaultQueries: [String: String] {
        return ["api-key": API_KEY]
    }
}
