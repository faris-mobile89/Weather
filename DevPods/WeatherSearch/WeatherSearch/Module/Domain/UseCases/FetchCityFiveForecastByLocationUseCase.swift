//
//  FetchCityFiveForecastByLocationUseCase.swift
//  WeatherSearch
//
//  Created by Faris Abu Saleem on 20/03/2020.
//

import Foundation
import PromiseKit

protocol FetchCityFiveForecastByLocationUseCase {
    
    func execute() -> Promise<CityForecast>
}


final class DefaultFetchCityFiveForecastByLocationUseCase: FetchCityFiveForecastByLocationUseCase{
    
    let locator: CurrentCityWeatherLocatorUseCase
    private let forecastRepository: ForecastsRepository
    
    init(locatorUseCase: CurrentCityWeatherLocatorUseCase,
         forecastRepository:ForecastsRepository){
        
        self.locator = locatorUseCase
        self.forecastRepository = forecastRepository
    }
    
    func execute() -> Promise<CityForecast> {
        return Promise<CityForecast> { seal in
            firstly {
                locator.execute()
            }.then { [weak self] location -> Promise<FiveForecast> in
                guard let strongSelf = self else { return Promise.init(error: FiveForecastError.deallocated) }
                return strongSelf.forecastRepository.fiveForecastFor(Location: location)
            }.then { [weak self] forecasts -> Promise<CityForecast> in
                guard let strongSelf = self else { return Promise.init(error: FiveForecastError.deallocated) }
                let cityForecast = strongSelf.groupForecastsByDate(forecast: forecasts)
                return cityForecast
            }.done{ forecastResults in
                seal.fulfill(forecastResults)
            }.catch { (error) in
                seal.reject(error)
            }
        }
    }
    
    private func groupForecastsByDate(forecast:FiveForecast)-> Promise<CityForecast>{
        let forecasts = forecast.forecasts
        let grouped = Dictionary(grouping: forecasts, by: { $0.date } )
        
        let sorted = grouped.sorted(by: { $0.key.compare($1.key) == .orderedAscending })
        
        let results = sorted.map{
            DayForecast(date: $0.key, forcasts: $0.value)
        }

        return .value(CityForecast(cityName: forecast.city.name ?? "", daysForecast: results))
    }
   
}

enum FiveForecastError: Error{
       case notFound
       case deallocated
   }
