//
//  LiveDataServiceTests.swift
//  WallboxEMSTests
//
//  Created by Ruben Exposito Marin on 25/9/22.
//

import XCTest
import Combine
@testable import WallboxEMS

final class LiveDataServiceTests: XCTestCase {
    
    private var cancellables: Set<AnyCancellable>!
    
    override func setUpWithError() throws {
        super.setUp()
        cancellables = []
    }
    
    override func tearDownWithError() throws {
        
    }
    
    func test_LiveDataServiceCall_ReturnsCorrectValues() throws {
        let expectation = XCTestExpectation(description: "LiveDataServiceProtocol")
        let service: LiveDataServiceProtocol = LiveDataServiceMockUp()
        var liveData: LiveData?
        
        service.fetchLive()
            .sink { completion in
                guard case .finished = completion else { return }
                expectation.fulfill()
            } receiveValue: { (value: LiveData) in
                liveData = value
                expectation.fulfill()
            }
            .store(in: &cancellables)
        wait(for: [expectation], timeout: 0.5)
        
        XCTAssertNotNil(liveData)
        XCTAssertEqual(liveData!.solarPower, 7.827)
        XCTAssertEqual(liveData!.quasarsPower, -38.732)
        XCTAssertEqual(liveData!.gridPower, 80.475)
        XCTAssertEqual(liveData!.buildingConsumption, 127.03399999999999)
        XCTAssertEqual(liveData!.systemSoc, 48.333333333333336)
        XCTAssertEqual(liveData!.totalEnergy, 960)
        XCTAssertEqual(liveData!.currentEnergy, 464.0)
    }
}
