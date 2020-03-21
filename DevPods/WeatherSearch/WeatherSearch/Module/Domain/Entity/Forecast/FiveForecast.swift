//
//  FiveForecast.swift
//  WeatherSearch
//
//  Created by Faris Abu Saleem on 20/03/2020.
//

import Foundation

struct FiveForecast{
    let code:String
    let count:Int
    let forecasts:[Forecast]
    let city:City
}

extension FiveForecast: Codable{

    enum CodingKeys: String, CodingKey{
        case code = "cod", count = "cnt"
        case forecasts = "list"
        case city
    }
}



