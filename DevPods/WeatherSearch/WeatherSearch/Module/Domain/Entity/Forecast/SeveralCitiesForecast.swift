//
//  SeveralCitiesForecast.swift
//  WeatherSearch
//
//  Created by Faris Abu Saleem on 20/03/2020.
//

import Foundation

struct SeveralCitiesForecast {
    let count:Int
    let forecasts:[Forecast]
}

extension SeveralCitiesForecast: Codable{
    
    enum CodingKeys: String, CodingKey{
        case count     = "cnt"
        case forecasts = "list"
    }
}
