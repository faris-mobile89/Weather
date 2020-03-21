//
//  DefaultFetchSeveralCitiesForecastUseCaseTests.swift
//  WeatherSearch-Unit-Tests
//
//  Created by Faris Abu Saleem on 20/03/2020.
//

import XCTest
import PromiseKit
@testable import WeatherSearch

class DefaultFetchSeveralCitiesForecastUseCaseTests: XCTestCase {

    func testFetchMultipleCityForecast(){
        // Given
        let cities =  ["Dubai", "Amman", "London"]
        let expectation = self.expectation(description: "Forecast fetched")
        expectation.expectedFulfillmentCount = 1
        let cityStore = CityDataStoreDisk()
        let provider = DefaultWeatherMoyaProvider()
        let remoteAPI = CloudWeatherRemoteAPI(provider: provider)
        let forecastRepository = DefaultForecastRepository(remoteAPI: remoteAPI)
        let useCase = DefaultSearchCitiesForecastUseCase(forecastRepository: forecastRepository, cityStore: cityStore)
        // When
        var forecasts:SeveralCitiesForecast?
        
        firstly {
            useCase.execute(cities: cities)
        }.done { (citiesForcast) in
            forecasts = citiesForcast
            expectation.fulfill()
        }.catch { error in
            XCTFail("Failed to load forecast! \(error)")
        }
        
        // Then
        wait(for: [expectation], timeout: 20)
        
        XCTAssertNotNil(forecasts)
        XCTAssertEqual(forecasts?.count, 3)
    }
}
