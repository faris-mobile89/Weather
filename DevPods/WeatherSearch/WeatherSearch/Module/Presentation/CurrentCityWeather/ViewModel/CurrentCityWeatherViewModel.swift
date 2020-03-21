//
//  CurrentCityWeatherViewModel.swift
//  WeatherSearch
//
//  Created by Faris Abu Saleem on 21/03/2020.
//

import Foundation


protocol CurrentCityWeatherViewModelInput {}

protocol CurrentCityWeatherViewModelOutput {
    var forecast: Observable<CityForecast?> { get }
    var error: Observable<String> { get }
    var screenTitle: String { get }
}

protocol CurrentCityWeatherViewModel: CurrentCityWeatherViewModelInput, CurrentCityWeatherViewModelOutput {}


final class DefaultCurrentCityWeatherViewModel: CurrentCityWeatherViewModel{
    
    
    // MARK: - Output
    var forecast: Observable<CityForecast?> = Observable<CityForecast?>(nil)
    var error: Observable<String>  = Observable("")
    var screenTitle: String = "City Current Weather"
    
    // MARK: - Input
    
    
    let fetchCityFiveForecastByLocationUseCase: FetchCityFiveForecastByLocationUseCase
    
    init(fetchCityFiveForecastByLocationUseCase: FetchCityFiveForecastByLocationUseCase) {
        self.fetchCityFiveForecastByLocationUseCase = fetchCityFiveForecastByLocationUseCase
        
        self.fetchCityFiveForecastByLocationUseCase.execute()
            .done { [weak self] cityWeather in
            self?.forecast.value = cityWeather
        }.catch { [weak self] error in
            if let error = error as? FiveForecastError{
                switch error {
                case .notFound:
                    self?.error.value = "Unable to get weather forecast at your location!"
                case .deallocated:
                    break
                }
            }
        }
    }
}
