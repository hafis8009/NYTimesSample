//
//  URL+Utils.swift
//  Currency ConversionTests
//
//  Created by Hafiz on 11/01/2021.
//  Copyright © 2021 Hafiz. All rights reserved.
//

import Foundation

extension URL {
    func url(with querries: [URLQueryItem]) -> URL? {
        var urlComponents = URLComponents(url: self, resolvingAgainstBaseURL: false)
        urlComponents?.queryItems = querries
        return urlComponents?.url
    }
}
