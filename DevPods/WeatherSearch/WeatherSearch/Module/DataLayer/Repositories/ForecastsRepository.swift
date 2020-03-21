//
//  ForecastsRepository.swift
//  WeatherSearch
//
//  Created by Faris Abu Saleem on 19/03/2020.
//

import Foundation
import PromiseKit

protocol ForecastsRepository {
    
    func currentWeather(city: String) -> Promise<Forecast>
    
    func currentWeatherOfSeveralCities(ids:[String]) -> Promise<SeveralCitiesForecast>
    
    func fiveForecastFor(Location location:Location) -> Promise<FiveForecast>
}
