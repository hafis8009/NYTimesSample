//
//  ReachabilityAdapter.swift
//  GScent
//
//  Created by Hafiz Abdul kareem on 05/03/2021.
//  Copyright © 2021 Hafiz. All rights reserved.
//

import Foundation

protocol ReachabilityAdapter {
    var currentReachabilityStatus: Reachability.NetworkStatus { get }
}

extension Reachability: ReachabilityAdapter { }
