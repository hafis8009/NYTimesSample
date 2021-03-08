//
//  DashboardNetworkAdapterTests.swift
//  NYTimes
//
//  Created by Hafiz Abdul kareem on 07/03/2021.
//  Copyright © 2021 Hafiz. All rights reserved.
//

import XCTest
import Quick
import Nimble

@testable import NYTimes

class DashboardNetworkAdapterTests: QuickSpec {
    var networkClient: NetworkClientMock?
    var networkAdapter: DashboardNetworkAdapter?
    
    override func spec() {
        describe("DashboardNetworkAdapter Tests") {
            context("When invalid data received in the network call") {
                beforeEach {
                    let invalidData = Data("{\"wrongKey\":\"wrong value\"}".utf8)
                    self.networkClient = NetworkClientMock()
                    self.networkClient?.mockResponse = invalidData
                    self.networkAdapter = DashboardNetworkAdapter(networkClient: self.networkClient!)
                }
                
                it("Should return error") {
                    self.networkAdapter?.getDashboardItems() { models, error in
                        expect(error).toNot(beNil())
                    }
                }
                
                it("Should return nil result") {
                    self.networkAdapter?.getDashboardItems() { models, error in
                        expect(models).to(beNil())
                    }
                }
            }
            
            context("When valid data received in the network call") {
                beforeEach {
                    self.networkClient = NetworkClientMock()
                    self.networkClient?.mockResponse = JSONHelper.jsonFileToData(jsonName: "nyTimes", bundle: Bundle.testBundle)
                    self.networkAdapter = DashboardNetworkAdapter(networkClient: self.networkClient!)
                }

                it("Should not return error") {
                    self.networkAdapter?.getDashboardItems() { models, error in
                        expect(error).to(beNil())
                        expect(models).toNot(beNil())
                        expect(models?.results?.count == 20).to(beTrue())
                    }
                }
            }
        }
    }
}
