//
//  DashboardViewModelTests.swift
//  WallboxEMSTests
//
//  Created by Ruben Exposito Marin on 25/9/22.
//

import XCTest
import Combine
@testable import WallboxEMS

final class DashboardViewModelTests: XCTestCase {
    
    private let viewModel = DashboardViewModel()
    private var cancellables: Set<AnyCancellable>!
    
    let liveData = LiveData(
        buildingConsumption: 100.0,
        gridPower: 67.3,
        solarPower: 12.0,
        quasarsPower: 34.0,
        systemSoc: 34,
        totalEnergy: 200,
        currentEnergy: 12)
    
    let historicalData1 = HistoricalData(buildingConsumption: 12.0,
                                    gridPower: 34.0,
                                    solarPower: 67.3,
                                    quasarsPower: 100.0,
                                    timestamp: Date(timeIntervalSince1970: 0))
    
    let historicalData2 = HistoricalData(buildingConsumption: 14.0,
                                    gridPower: 36.0,
                                    solarPower: 69.3,
                                    quasarsPower: 102.0,
                                    timestamp: Date(timeIntervalSince1970: 10))
    
    override func setUpWithError() throws {
        super.setUp()
        cancellables = []
    }
    
    override func tearDownWithError() throws {
        
    }
    
    // MARK: Initialization
    
    func testInit_DashboardViewModel() {
        XCTAssertNotNil(viewModel)
        XCTAssertEqual(viewModel.energyChargedFromQuasar, "kWh")
        XCTAssertEqual(viewModel.energyDischargedFromQuasar, "kWh")
        XCTAssertEqual(viewModel.errorDescription, "Something went wrong")
        XCTAssertFalse(viewModel.isError)
        XCTAssertTrue(viewModel.historicalData.isEmpty)
        XCTAssertNil(viewModel.liveData)
        
        // Live data
        XCTAssertEqual(viewModel.solar, "0.00 kWh")
        XCTAssertEqual(viewModel.quasars, "0.00 kWh")
        XCTAssertEqual(viewModel.grid, "0.00 kWh")
        XCTAssertEqual(viewModel.demand, "0.00 kWh")
        
        // Statistics data
        XCTAssertEqual(viewModel.gridTitle, "Grid")
        XCTAssertEqual(viewModel.solarTitle, "Solar")
        XCTAssertEqual(viewModel.quasarTitle, "Quasar")
        XCTAssertEqual(viewModel.gridPercentageFormatted, "0.0")
        XCTAssertEqual(viewModel.solarPercentageFormatted, "0.0")
        XCTAssertEqual(viewModel.quasarPercentageFormatted, "0.0")
        
        // Charts data
        XCTAssertTrue(viewModel.charts.isEmpty)
    }
    
    func test_Init_DashboardViewModel_LiveData() {
        XCTAssertEqual(viewModel.solar, "0.00 kWh")
        XCTAssertEqual(viewModel.quasars, "0.00 kWh")
        XCTAssertEqual(viewModel.grid, "0.00 kWh")
        XCTAssertEqual(viewModel.demand, "0.00 kWh")
        viewModel.liveData = liveData
        XCTAssertEqual(viewModel.solar, "12.00 kWh")
        XCTAssertEqual(viewModel.quasars, "34.00 kWh")
        XCTAssertEqual(viewModel.grid, "67.30 kWh")
        XCTAssertEqual(viewModel.demand, "100.00 kWh")
    }
    
    func test_Init_DashboardViewModel_StatisticsData() {
        XCTAssertEqual(viewModel.gridTitle, "Grid")
        XCTAssertEqual(viewModel.solarTitle, "Solar")
        XCTAssertEqual(viewModel.quasarTitle, "Quasar")
        XCTAssertEqual(viewModel.gridPercentageFormatted, "0.0")
        XCTAssertEqual(viewModel.solarPercentageFormatted, "0.0")
        XCTAssertEqual(viewModel.quasarPercentageFormatted, "0.0")
        viewModel.historicalData = [historicalData1, historicalData1]
        XCTAssertEqual(viewModel.gridPercentageFormatted, "283.3")
        XCTAssertEqual(viewModel.solarPercentageFormatted, "560.8")
        XCTAssertEqual(viewModel.quasarPercentageFormatted, "0.0")
    }
    
    func test_Init_DashboardViewModel_ChartsData() {
        XCTAssertTrue(viewModel.charts.isEmpty)
        viewModel.historicalData = [historicalData2, historicalData1]
        let charts = [
            ChartElement(date: Date(timeIntervalSince1970: 0), power: 34.0, type: .grid),
            ChartElement(date: Date(timeIntervalSince1970: 10), power: 36.0, type: .grid),
            ChartElement(date: Date(timeIntervalSince1970: 0), power: 67.3, type: .solar),
            ChartElement(date: Date(timeIntervalSince1970: 10), power: 69.3, type: .solar),
            ChartElement(date: Date(timeIntervalSince1970: 0), power: -100.0, type: .quasar),
            ChartElement(date: Date(timeIntervalSince1970: 10), power: -102.0, type: .quasar),
            ChartElement(date: Date(timeIntervalSince1970: 0), power: 12.0, type: .buildingConsumption),
            ChartElement(date: Date(timeIntervalSince1970: 10), power: 14.0, type: .buildingConsumption)
        ]
        XCTAssertEqual(viewModel.charts, charts)
    }
}
