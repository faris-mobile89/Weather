//
//  SearchWeatherViewModel.swift
//  WeatherSearch
//
//  Created by Faris Abu Saleem on 21/03/2020.
//

import Foundation
import PromiseKit

enum SearchWeatherViewModelRoute {
    case initial
    case showSearchWeatherDetail(title: String, forecast: SeveralCitiesForecast)
}

protocol SearchWeatherViewModelInput {
    func didSearch(query: String)
}

protocol SearchWeatherViewModelOutput {
    var route: Observable<SearchWeatherViewModelRoute> { get }
    var query: Observable<String> { get }
    var error: Observable<String> { get }
    var screenTitle: String { get }
}

protocol SearchWeatherViewModel: SearchWeatherViewModelInput, SearchWeatherViewModelOutput {}


final class DefaultSearchWeatherViewModel: SearchWeatherViewModel{
    
    
    // MARK: - Output
    var route: Observable<SearchWeatherViewModelRoute> = Observable(.initial)
    var query: Observable<String>  = Observable("")
    var error: Observable<String>  = Observable("")
    var screenTitle: String = "Search Weather"
    
    // MARK: - Input
    func didSearch(query: String) {
        let query = query.removeWhitespace()
        let cities = query.components(separatedBy: ",")
        firstly {
            searchForecastUseCase.execute(cities: cities)
        }.done { [weak self] results in
            self?.route.value = .showSearchWeatherDetail(title: "Weather", forecast: results)
        }.catch {  [weak self] error in
            if let error = error as? CityInputError{
                switch error {
                case .empty:
                    self?.error.value = "Can't be empty"
                case .insufficient:
                    self?.error.value = "Query should be more than 3"
                case .overflow:
                    self?.error.value = "Query should be less than 7"
                }
            }
        }
    }
    
    
    let searchForecastUseCase:SearchSeveralCitiesForecastUseCase
    
    init(searchForecastUseCase: SearchSeveralCitiesForecastUseCase) {
        self.searchForecastUseCase = searchForecastUseCase
    }
}
