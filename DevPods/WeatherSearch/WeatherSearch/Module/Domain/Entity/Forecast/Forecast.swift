//
//  Forecast.swift
//  WeatherSearch
//
//  Created by Faris Abu Saleem on 19/03/2020.
//

import Foundation

//•    Temperature (Min and Max),
//•    Weather (description),
//•    Wind Speed

struct Forecast: Codable {
    let cityName:String?
    let temperature:Temperature
    let weather:[Weather]
    let wind:Wind
    let datetime:String?
    
    var date:String {
        let dateTimeFormatter = DateFormatter()
        dateTimeFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        guard let datetime = datetime else {return "" }
        guard let dateTime = dateTimeFormatter.date(from: datetime) else { return "" }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        return dateFormatter.string(from: dateTime)
    }
    
    enum CodingKeys: String, CodingKey {
        case temperature = "main"
        case weather
        case wind
        case cityName = "name"
        case datetime = "dt_txt"
    }
}

struct Temperature: Codable{
    var temp, min, max:Double?
    
    enum CodingKeys: String, CodingKey {
        case temp
        case min = "temp_min"
        case max = "temp_max"
    }
}

struct Wind: Codable{
    var speed:Double?
}

struct Weather: Codable{
    var main:String?
    var description:String?
    var icon:String?
}
