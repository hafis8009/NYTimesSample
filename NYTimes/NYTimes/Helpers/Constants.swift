//
//  Constants.swift
//  GScent
//
//  Created by Hafiz Abdul kareem on 05/03/2021.
//  Copyright © 2021 Hafiz. All rights reserved.
//
// swiftlint:disable identifier_name

import Foundation
import UIKit

let API_KEY = "AjhBT5zEiwnAkmQN6A5gKGsVsP2Gy7WV"

// TODO : Localise all below constant texts
struct UIStrings {
    static let genericErrorMessage = "Some error occured. Please try again later"
    static let genericErrorTitle = "Error"
    static let badURLErrorMessage = "Something went bad. Please talk to the admin"
}

struct Endpoints {
    static let getDashboardItems = NetworkEndpointModel(baseUrl: "https://api.nytimes.com", path: "/svc/mostpopular/v2/viewed/1.json", offlineFileName: nil)
}

let imageCache = NSCache<NSString, UIImage>()
