//
//  SearchDetailsViewModel.swift
//  WeatherSearch
//
//  Created by Faris Abu Saleem on 21/03/2020.
//

import Foundation


protocol SearchDetailsViewlInput {}

protocol SearchDetailsViewOutput {
    var title: Observable<String> { get }
    var forecast: Observable<SeveralCitiesForecast?> { get }
}

protocol SearchDetailsViewModel: SearchDetailsViewlInput, SearchDetailsViewOutput {}


class DefaultSearchDetailsViewModel: SearchDetailsViewModel{
    
    // MARK: - Output
    var title: Observable<String>  = Observable("")
    var forecast: Observable<SeveralCitiesForecast?>  = Observable(nil)
    
    init(title: String, forecast: SeveralCitiesForecast) {
        self.title.value = title
        self.forecast.value = forecast
    }
}


