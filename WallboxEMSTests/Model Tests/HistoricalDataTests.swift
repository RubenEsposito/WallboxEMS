//
//  HistoricalDataTests.swift
//  WallboxEMSTests
//
//  Created by Ruben Exposito Marin on 24/9/22.
//

import XCTest
@testable import WallboxEMS

final class HistoricalDataTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    // MARK: Initialization
    
    func testInit_HistoricalData() {
        let testHistoricalData = HistoricalData(buildingConsumption: 100,
                                                gridPower: 10,
                                                solarPower: 20,
                                                quasarsPower: -20,
                                                timestamp: Date(timeIntervalSince1970: 0))
        
        XCTAssertNotNil(testHistoricalData)
        XCTAssertEqual(testHistoricalData.buildingConsumption, 100)
        XCTAssertEqual(testHistoricalData.gridPower, 10)
        XCTAssertEqual(testHistoricalData.solarPower, 20)
        XCTAssertEqual(testHistoricalData.quasarsPower, -20)
        XCTAssertEqual(testHistoricalData.timestamp, Date(timeIntervalSince1970: 0))
    }
}
