//
//  NetworkClientMock.swift
//  NYTimesTests
//
//  Created by Hafiz Abdul kareem on 07/03/2021.
//  Copyright © 2021 Hafiz. All rights reserved.
//

import Foundation

@testable import NYTimes

class NetworkClientMock: NetworkClientAdaptable {
    var mockResponse: Any?
    var mockError: CoreError?

    func sendRequest(withRequestBody requestBody: String?, requestHeaders: Headers, queryParameters: Parameters, completionHandler: @escaping NetworkCompletionBlock) {
        completionHandler(self.mockResponse, nil, self.mockError)
    }
}
