//
//  SearchByCityNameUseCase.swift
//  WeatherSearch
//
//  Created by Faris Abu Saleem on 19/03/2020.
//

import Foundation
import PromiseKit

protocol FetchCityForecastUseCase {
    
    func execute(requestValue: FetchCityForecastUseCaseRequestValue) -> Promise<Forecast>
}


final class DefaultFetchCityForecastUseCase: FetchCityForecastUseCase{
    
    private let forecastRepository: ForecastsRepository

    init(forecastRepository:ForecastsRepository) {
        self.forecastRepository = forecastRepository
    }
    
    func execute(requestValue: FetchCityForecastUseCaseRequestValue) -> Promise<Forecast> {
        forecastRepository.currentWeather(city: requestValue.name)
    }
}


struct FetchCityForecastUseCaseRequestValue {
    let name: String
}
