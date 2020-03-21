//
//  WeatherMoyaProvider.swift
//  WeatherSearch
//
//  Created by Faris Abu Saleem on 19/03/2020.
//

import Foundation
import Moya

protocol WeatherMoyaProvider {
    func makeWeatherMoyaProvider() -> MoyaProvider<WeatherAPIService>
}
