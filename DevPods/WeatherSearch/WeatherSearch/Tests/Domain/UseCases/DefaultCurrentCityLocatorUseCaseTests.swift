//
//  DefaultCurrentCityLocatorUseCaseTests.swift
//  WeatherSearch-Unit-Tests
//
//  Created by Faris Abu Saleem on 20/03/2020.
//

import XCTest
import PromiseKit
@testable import WeatherSearch

class DefaultCurrentCityLocatorUseCaseTests: XCTestCase {
    
    func testFethCityLocation(){
        // Given
        let fakeUserLocator = FakeUserLocator()
        let useCase = DefaultCurrentCityWeatherLocatorUseCase(locator: fakeUserLocator)
        let expectation = self.expectation(description: "User's location fetched")
        expectation.expectedFulfillmentCount = 1
        var userLocation:Location?
        // When
        firstly {
            useCase.execute()
        }.done { (location) in
            userLocation = location
            expectation.fulfill()
        }.catch { (error) in
            XCTFail("Failed to get location! \(error))")
        }
        //then
        wait(for: [expectation], timeout: 9)
        
        XCTAssertNotNil(userLocation)
        XCTAssertEqual(userLocation?.latitude, 35.94503)
        XCTAssertEqual(userLocation?.longitude, 31.955219)
    }
    
}
