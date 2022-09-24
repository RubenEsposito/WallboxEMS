//
//  LiveDataTests.swift
//  WallboxEMSTests
//
//  Created by Ruben Exposito Marin on 24/9/22.
//

import XCTest
@testable import WallboxEMS

final class LiveDataTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    // MARK: Initialization
    
    func testInit_LiveData() {
        let testLiveData = LiveData(buildingConsumption: 100,
                                    gridPower: 10,
                                    solarPower: 20,
                                    quasarsPower: -20,
                                    systemSoc: 12,
                                    totalEnergy: 300,
                                    currentEnergy: 100)
        
        XCTAssertNotNil(testLiveData)
        XCTAssertEqual(testLiveData.buildingConsumption, 100)
        XCTAssertEqual(testLiveData.gridPower, 10)
        XCTAssertEqual(testLiveData.solarPower, 20)
        XCTAssertEqual(testLiveData.quasarsPower, -20)
        XCTAssertEqual(testLiveData.systemSoc, 12)
        XCTAssertEqual(testLiveData.totalEnergy, 300)
        XCTAssertEqual(testLiveData.currentEnergy, 100)
    }
}
