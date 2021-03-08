//
//  Dictionary+Utils.swift
//  Currency ConversionTests
//
//  Created by Hafiz on 11/01/2021.
//  Copyright © 2021 Hafiz. All rights reserved.
//

import Foundation

extension Dictionary where Key == String, Value == String {
    func toURLQuerryItems() -> [URLQueryItem]? {
        return self.map { key, val in
            URLQueryItem(name: key, value: val)
        }
    }
    
    var isNonEmpty: Bool {
        return !isEmpty
    }
    
    mutating func merge(dict: [Key: Value]) {
        for (key, value) in dict {
            updateValue(value, forKey: key)
        }
    }
}
