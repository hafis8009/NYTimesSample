//
//  JSONHelper.swift
//  GScent
//
//  Created by Hafiz Abdul kareem on 05/03/2021.
//  Copyright © 2021 Hafiz. All rights reserved.
//

import Foundation

class JSONHelper {
    enum NetworkResponseKeys: String {
        case model
        case httpStatus
    }
    
    static func wrappedJSONFileToDataAndHttpStatus(jsonName: String) -> (data: Data?, httpStatus: Int?) {
        guard let path = Bundle.main.path(forResource: jsonName, ofType: "json"),
            let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe) else { return (nil, nil) }
        let jsonDict = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        
        var jsonData: Data?
        if let model = jsonDict?[JSONHelper.NetworkResponseKeys.model.rawValue] {
            jsonData = try? JSONSerialization.data(withJSONObject: model, options: [])
        }
        
        let status = jsonDict?[JSONHelper.NetworkResponseKeys.httpStatus.rawValue] as? Int
        return (jsonData, status)
    }
    
    static func jsonFileToData(jsonName: String, bundle: Bundle = Bundle.main) -> Data? {
        guard let filePath = bundle.path(forResource: jsonName, ofType: "json") else {
            return nil
        }
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: filePath), options: .mappedIfSafe)
            let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            
            var jsonData: Data?
            if let model = json?[JSONHelper.NetworkResponseKeys.model.rawValue] {
                jsonData = try? JSONSerialization.data(withJSONObject: model, options: [])
            }
            return jsonData
        } catch {
            return nil
        }
    }
}
