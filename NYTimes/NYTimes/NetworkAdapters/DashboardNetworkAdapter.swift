//
//  DashboardNetworkAdapter.swift
//  GScent
//
//  Created by Hafiz Abdul kareem on 05/03/2021.
//  Copyright © 2021 Hafiz. All rights reserved.
//

import Foundation

// swiftlint:disable force_cast
class DashboardNetworkAdapter {
    let networkClient: NetworkClientAdaptable
    
    init(networkClient: NetworkClientAdaptable) {
        self.networkClient = networkClient
    }
    
    func getDashboardItems(completion: @escaping (DashboardSectionModel?, CoreError?) -> Void) {
        networkClient.sendRequest(withRequestBody: nil,
                                  requestHeaders: [:],
                                  queryParameters: [:]) { response, headers, error in
            if error == nil, response != nil {
                do {
                    let decoder = JSONDecoder()
                    let sections = try decoder.decode(DashboardSectionModel.self, from: response as! Data)
                    completion(sections, nil)
                } catch {
                    completion(nil, CoreError(error: error))
                }
            } else if error == nil {
                completion(nil, CoreError.init(type: .invalidRequestFormat))
            }else {
                completion(nil, error)
            }
        }
    }
}
