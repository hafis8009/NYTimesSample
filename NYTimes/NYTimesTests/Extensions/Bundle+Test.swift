//
//  Bundle+Test.swift
//  NYTimesTests
//
//  Created by Hafiz Abdul kareem on 08/03/2021.
//  Copyright © 2021 Hafiz. All rights reserved.
//

import Foundation

extension Bundle {
    class var testBundle: Bundle {
        return Bundle(for: TestsConstants.self)
    }
}

class TestsConstants {
    static let defaultNavigationTimeout: DispatchTimeInterval = .seconds(100)
}
