//
//  DefaultWeatherMoyaProvider.swift
//  WeatherSearch
//
//  Created by Faris Abu Saleem on 19/03/2020.
//

import Foundation
import Moya

class DefaultWeatherMoyaProvider: WeatherMoyaProvider{
    
    func makeWeatherMoyaProvider() -> MoyaProvider<WeatherAPIService> {
        let logger = makeLoggerPlugin()
        return MoyaProvider<WeatherAPIService>(plugins: [logger])
    }
    
    private func makeLoggerPlugin() -> PluginType {
        return NetworkLoggerPlugin()
    }
}

