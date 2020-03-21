//
//  FakeWeatherRemoteAPI.swift
//  WeatherSearch
//
//  Created by Faris Abu Saleem on 20/03/2020.
//

import Foundation
import PromiseKit

final class FakeWeatherRemoteAPI: ForecastRemoteAPI{
    
    private let fakeForecast = Forecast(cityName: "Ajman", temperature:
        Temperature(temp: 15, min: 10, max: 15), weather: [], wind: Wind(speed: 14), datetime: "")
    
    func currentWeather(city: String) -> Promise<Forecast> {
        .value(fakeForecast)
    }
    
    func forcastOFSeveralCities(ids: [String]) -> Promise<SeveralCitiesForecast> {
        .value( SeveralCitiesForecast(count: 1 , forecasts: [fakeForecast]) )
    }
    
    func fiveForecastFor(Location location: Location) -> Promise<FiveForecast> {
        let city = City(id: 1, name: "Ajman")
        let forecasts = FiveForecast(code: "200", count: 1, forecasts: [fakeForecast], city: city)
        return .value (forecasts)
    }
}
