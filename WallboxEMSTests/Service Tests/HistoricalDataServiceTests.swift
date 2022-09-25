//
//  HistoricalDataServiceTests.swift
//  WallboxEMSTests
//
//  Created by Ruben Exposito Marin on 25/9/22.
//

import XCTest
import Combine
@testable import WallboxEMS

final class HistoricalDataServiceTests: XCTestCase {
    
    private var cancellables: Set<AnyCancellable>!
    
    override func setUpWithError() throws {
        super.setUp()
        cancellables = []
    }
    
    override func tearDownWithError() throws {
        
    }
    
    func test_HistoricalDataServiceCall_ReturnsCorrectValues() throws {
        let expectation = XCTestExpectation(description: "HistoricalDataServiceProtocol")
        let service: HistoricalDataServiceProtocol = HistoricalDataServiceMockUp()
        var historicalData: [HistoricalData] = []
        
        service.fetchHistorical()
            .sink { completion in
                guard case .finished = completion else { return }
                expectation.fulfill()
            } receiveValue: { (value: [HistoricalData]) in
                historicalData = value
                expectation.fulfill()
            }
            .store(in: &cancellables)
        wait(for: [expectation], timeout: 0.5)
        
        XCTAssertFalse(historicalData.isEmpty)
        XCTAssertEqual(historicalData.first!.buildingConsumption, 40.47342857142857)
        XCTAssertEqual(historicalData.first!.gridPower, 44.234380952380945)
        XCTAssertEqual(historicalData.first!.solarPower, 0.0)
        XCTAssertEqual(historicalData.first!.quasarsPower, 3.7609523809523817)
        XCTAssertEqual(historicalData.first!.timestamp, ISO8601DateFormatter().date(from: "2021-09-26T22:01:00+00:00")!)
    }
}
