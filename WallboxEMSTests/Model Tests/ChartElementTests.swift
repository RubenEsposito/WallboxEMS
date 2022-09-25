//
//  ChartElementTests.swift
//  WallboxEMSTests
//
//  Created by Ruben Exposito Marin on 25/9/22.
//

import XCTest
@testable import WallboxEMS

final class ChartElementTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    // MARK: Initialization
    
    func testInit_ChartElement() {
        let testChartElement = ChartElement(date: Date(timeIntervalSince1970: 0), power: 10, type: .solar)
        
        XCTAssertNotNil(testChartElement)
        XCTAssertEqual(testChartElement.id, Date(timeIntervalSince1970: 0))
        XCTAssertEqual(testChartElement.date, Date(timeIntervalSince1970: 0))
        XCTAssertEqual(testChartElement.power, 10)
        XCTAssertEqual(testChartElement.type, .solar)
    }
}
