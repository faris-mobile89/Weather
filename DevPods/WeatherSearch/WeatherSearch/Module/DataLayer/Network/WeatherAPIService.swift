//
//  WeatherAPIService.swift
//  WeatherSearch
//
//  Created by Faris Abu Saleem on 19/03/2020.
//

import Foundation
import Moya

enum WeatherAPIService {
    case currentWeatherOf(city: String)
    case forcastOFSeveralCities(ids:[String])
    case fiveForecastByGeoLocation(latitude:Latitude, longitude:Longitude)
}

typealias ParameterDictionary = [String: Any]

// MARK: - TargetType Protocol Implementation
extension WeatherAPIService: TargetType {
    
    var baseURL: URL {
        assert(!WeatherAPI.apiKey.isEmpty)
          var url = URL(string: WeatherAPI.baseUrl)!
              url = url.appendingPathComponent(WeatherAPI.dataPath)
              url = url.appendingPathComponent(WeatherAPI.apiVersion)
              return url
    }
    
    var path: String {
        switch self {
        case .currentWeatherOf:
            return "weather"
        case .forcastOFSeveralCities:
            return "group"
        case .fiveForecastByGeoLocation:
            return "forecast"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .currentWeatherOf:
            return .get
        case .forcastOFSeveralCities:
            return .get
        case .fiveForecastByGeoLocation:
            return .get
        }
    }
    
    var task: Task {
        var params: ParameterDictionary = ["appid": WeatherAPI.apiKey, "units": WeatherAPI.units]
        switch self {
        case .currentWeatherOf(let city):
             params += ["q": city]
        case .forcastOFSeveralCities(let ids):
            params += ["id": ids.joined(separator: ",")]
        case .fiveForecastByGeoLocation(let latitude, let longitude):
            params += ["lat": latitude, "lon": longitude]
        }
         return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
    }
    
    var sampleData: Data {
        switch self {
        case .currentWeatherOf:
            return "{}".utf8Encoded
        case .forcastOFSeveralCities:
            return "{}".utf8Encoded
        case .fiveForecastByGeoLocation:
            return "{}".utf8Encoded
        }
    }
    
    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
}

func += (lhs: inout ParameterDictionary, rhs: ParameterDictionary) {
  for key in rhs.keys {
    lhs[key] = rhs[key]
  }
}

// MARK: - Helpers
extension String {
    
    var utf8Encoded: Data {
        return data(using: .utf8)!
    }
}
