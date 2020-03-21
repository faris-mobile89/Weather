//
//  FetchCityForecastUseCaseTests.swift
//  WeatherSearch-Unit-Tests
//
//  Created by Faris Abu Saleem on 19/03/2020.
//

import XCTest
import PromiseKit
import Moya
@testable import WeatherSearch

class FetchCityForecastUseCaseTests: XCTestCase {

    static let fakeForecast = Forecast(cityName: "Dubai", temperature:
        Temperature(temp: 15, min: 10, max: 15), weather: [], wind: Wind(speed: 14), datetime: "")

    class CityForecastFake:ForecastsRepository {
        
        func fiveForecastFor(Location location: Location) -> Promise<FiveForecast> {
            let city = City(id: 0, name: "")
            return .value(FiveForecast(code: "404", count: 1, forecasts: [], city: city))
        }
        
        func currentWeatherOfSeveralCities(ids: [String]) -> Promise<SeveralCitiesForecast> {
            return .value(SeveralCitiesForecast(count: 0, forecasts: []))
        }
        
        func currentWeather(city: String) -> Promise<Forecast> {
            return Promise<Forecast> { seal in
                seal.fulfill(fakeForecast)
            }
        }
    }
    
    func testFakeCityForecastQuerySuccessfully(){
        // Given
        let forecastRepository = CityForecastFake()
        
        let expectation = self.expectation(description: "Forecast fetched")
        expectation.expectedFulfillmentCount = 1
        
        let useCase = DefaultFetchCityForecastUseCase(forecastRepository: forecastRepository)
        
        let requestValue = FetchCityForecastUseCaseRequestValue(name: "Dubai")
        
         // When
        var forecast:Forecast?
        
        firstly {
            useCase.execute(requestValue: requestValue)
        }.done { (forecastObj) in
            forecast = forecastObj
           expectation.fulfill()
        }.catch { (error) in
            XCTFail("Failed to load forecast")
            expectation.fulfill()
        }
        
        // Then
        wait(for: [expectation], timeout: 30)
        XCTAssertTrue(forecast?.temperature.max == 15.0)
    }
    
    func testAPICityForecastQuerySuccessfully_RemoteAPI(){
        // Given
        let provider = DefaultWeatherMoyaProvider()
        let remoteAPI = CloudWeatherRemoteAPI(provider: provider)
        let forecastRepository = DefaultForecastRepository(remoteAPI: remoteAPI)
        let expectation = self.expectation(description: "Forecast fetched")
        expectation.expectedFulfillmentCount = 1
        
        let useCase = DefaultFetchCityForecastUseCase(forecastRepository: forecastRepository)
        
        let requestValue = FetchCityForecastUseCaseRequestValue(name: "Dubai")
        
         // When
        var forecast:Forecast?
        
        firstly {
            useCase.execute(requestValue: requestValue)
        }.done { (forecastObj) in
            forecast = forecastObj
           expectation.fulfill()
        }.catch { (error) in
            print("☠️ \(error.localizedDescription)")
            XCTFail("Failed to fetch forecast")
        }
        
        // Then
        wait(for: [expectation], timeout: 30)
        XCTAssertNotNil(forecast, "forecast is nil")
        XCTAssertNotNil(forecast?.temperature)
        XCTAssertNotNil(forecast?.weather)
        XCTAssertNotNil(forecast?.wind)
        XCTAssertNotNil(forecast?.temperature.min)
        XCTAssertNotNil(forecast?.temperature.max)
        XCTAssertEqual(forecast?.cityName, "Dubai")
    }
    
    func testAPICityForecastQuerySuccessfully_FakeRemoteAPI(){
          // Given
          let fakeAPI = FakeWeatherRemoteAPI()
          let forecastRepository = DefaultForecastRepository(remoteAPI: fakeAPI)
          let expectation = self.expectation(description: "Forecast fetched")
          expectation.expectedFulfillmentCount = 1
          
          let useCase = DefaultFetchCityForecastUseCase(forecastRepository: forecastRepository)
          
          let requestValue = FetchCityForecastUseCaseRequestValue(name: "Ajman")
          
           // When
          var forecast:Forecast?
          
          firstly {
              useCase.execute(requestValue: requestValue)
          }.done { (forecastObj) in
              forecast = forecastObj
             expectation.fulfill()
          }.catch { (error) in
              print("☠️ \(error.localizedDescription)")
              XCTFail("Failed to fetch forecast")
          }
          
          // Then
          wait(for: [expectation], timeout: 30)
          XCTAssertNotNil(forecast, "forecast is nil")
          XCTAssertNotNil(forecast?.temperature)
          XCTAssertNotNil(forecast?.weather)
          XCTAssertNotNil(forecast?.wind)
          XCTAssertNotNil(forecast?.temperature.min)
          XCTAssertNotNil(forecast?.temperature.max)
          XCTAssertEqual(forecast?.cityName, "Ajman")
      }
    
}
