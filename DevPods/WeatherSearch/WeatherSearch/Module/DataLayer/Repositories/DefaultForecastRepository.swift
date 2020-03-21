//
//  DefaultForecastRepository.swift
//  WeatherSearch
//
//  Created by Faris Abu Saleem on 19/03/2020.
//

import Foundation
import PromiseKit

public class DefaultForecastRepository {
    
    private let remoteAPI: ForecastRemoteAPI
    
    //TDOD: Add Cache store
    
    init(remoteAPI: ForecastRemoteAPI) {
        self.remoteAPI = remoteAPI
    }
    
}

extension DefaultForecastRepository: ForecastsRepository {
    
    func currentWeather(city: String) -> Promise<Forecast> {
        remoteAPI.currentWeather(city: city)
    }
    
    func currentWeatherOfSeveralCities(ids: [String]) -> Promise<SeveralCitiesForecast> {
        remoteAPI.forcastOFSeveralCities(ids: ids)
    }
    
    func fiveForecastFor(Location location: Location) -> Promise<FiveForecast> {
        remoteAPI.fiveForecastFor(Location: location)
    }
}
