//
//  DefaultFetchCityFiveForecastByLocationUseCaseTests.swift
//  WeatherSearch-Unit-Tests
//
//  Created by Faris Abu Saleem on 20/03/2020.
//

import XCTest
import PromiseKit
@testable import WeatherSearch

class DefaultFetchCityFiveForecastByLocationUseCaseTests: XCTestCase {
    
    func testRemoteFiveDaysForecastByCityLocation(){
        // Given
        let fakeLocator = FakeUserLocator()
        let fakeLocatoreUseCase = DefaultCurrentCityWeatherLocatorUseCase(locator: fakeLocator)
        let provider = DefaultWeatherMoyaProvider()
        let remoteAPI = CloudWeatherRemoteAPI(provider: provider)
        let repository = DefaultForecastRepository(remoteAPI: remoteAPI)
        let useCase = DefaultFetchCityFiveForecastByLocationUseCase(locatorUseCase: fakeLocatoreUseCase, forecastRepository: repository)
        let expectation = self.expectation(description: "five days forecast")
        expectation.expectedFulfillmentCount = 1
        var fiveDaysForecast:[DayForecast]?
        // When
        firstly {
            useCase.execute()
        }.done { (forecast) in
            fiveDaysForecast = forecast.daysForecast
            expectation.fulfill()
        }.catch { (error) in
            XCTFail("Failed to get five days forecast! \(error)")
        }
        
        //then
        wait(for: [expectation], timeout: 15)
        
        XCTAssertNotNil(fiveDaysForecast)
        //MARK: The service returns 6 days forecast, I don't know why!
        XCTAssertGreaterThanOrEqual(fiveDaysForecast?.count ?? 0, 5)
    }
}
