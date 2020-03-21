//
//  FetchSeveralCitiesForecastUseCase.swift
//  WeatherSearch
//
//  Created by Faris Abu Saleem on 19/03/2020.
//

import Foundation
import PromiseKit


typealias ServeralCities = [String]

protocol SearchSeveralCitiesForecastUseCase {
    
    func execute(cities:ServeralCities) -> Promise<SeveralCitiesForecast>
}

final class DefaultSearchCitiesForecastUseCase: SearchSeveralCitiesForecastUseCase{
    
    let cityStore:CityStore
    private let forecastRepository: ForecastsRepository
    
    init(forecastRepository:ForecastsRepository,
         cityStore:CityStore){
        
        self.cityStore = cityStore
        self.forecastRepository = forecastRepository
    }
    
    func execute(cities: ServeralCities) -> Promise<SeveralCitiesForecast> {
        let validator = CityValidation(inputs: cities)
        do{
            let isValid = try validator.validate()
            if !isValid {
                return .init(error: CityInputError.empty)
            }
            
            let cities = cityStore.fetch(cities: cities)
            let citiesId = cities.compactMap{ String($0.id) }
            
            return forecastRepository.currentWeatherOfSeveralCities(ids: citiesId)
        }catch let error{
            return .init(error: error)
        }
    }
}
