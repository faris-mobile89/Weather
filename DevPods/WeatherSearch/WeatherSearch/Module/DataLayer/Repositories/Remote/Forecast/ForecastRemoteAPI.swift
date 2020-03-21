//
//  ForecastRemoteAPI.swift
//  WeatherSearch
//
//  Created by Faris Abu Saleem on 19/03/2020.
//

import Foundation
import PromiseKit

protocol ForecastRemoteAPI {
    
    /**
     Current weather data for a city
     
     - Parameter city: City name.
     
     - Returns: `Forecast` that match a searching word.
     */
    func currentWeather(city: String) -> Promise<Forecast>
    
    /**
     Current weather data for several cities
     
     - Parameter ids: Several city ID.
     
     - Returns: `SeveralCitiesForecast` An object contains cities forecast.
     */
    func forcastOFSeveralCities(ids:[String]) -> Promise<SeveralCitiesForecast>
    
    
    /**
     Weather forecast for 5 days with data every 3 hours
     
     - Parameter location: Location.
     
     - Returns: `FiveForecast` forecast for 5 days with data every 3 hours.
     */
    func fiveForecastFor(Location location:Location) -> Promise<FiveForecast>
    
}
