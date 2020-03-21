//
//  CloudWeatherRemoteAPI.swift
//  WeatherSearch
//
//  Created by Faris Abu Saleem on 19/03/2020.
//

import Foundation
import Moya
import PromiseKit

final class CloudWeatherRemoteAPI: ForecastRemoteAPI {
    
    let provider: WeatherMoyaProvider
    
    init(provider: WeatherMoyaProvider) {
        self.provider = provider
    }
    
    //TODO: Refeactor the implementation to avoid boilerplate code
    func currentWeather(city: String) -> Promise<Forecast> {
        return Promise<Forecast> { seal in
            let endPoint = WeatherAPIService.currentWeatherOf(city: city)
            provider.makeWeatherMoyaProvider().request(endPoint) { result in
                switch result {
                case let .success(moyaResponse):
                    let data = moyaResponse.data
                    let statusCode = moyaResponse.statusCode
                    
                    guard 200..<300 ~= statusCode else {
                        seal.reject(RemoteAPIError.httpError)
                        return
                    }
                    
                    do {
                        let decoder = JSONDecoder()
                        let forecast = try decoder.decode(Forecast.self, from: data)
                        seal.fulfill(forecast)
                    } catch let error{
                       seal.reject(RemoteAPIError.parseError(error: error))
                    }
                    
                case .failure(_):
                    seal.reject(RemoteAPIError.unknown)
                }
            }
        }
    }
    
    //TODO: Refeactor the implementation to avoid boilerplate code
    func forcastOFSeveralCities(ids: [String]) -> Promise<SeveralCitiesForecast> {
        return Promise<SeveralCitiesForecast> { seal in
            let endPoint = WeatherAPIService.forcastOFSeveralCities(ids: ids)
            provider.makeWeatherMoyaProvider().request(endPoint) { result in
                switch result {
                case let .success(moyaResponse):
                    let data = moyaResponse.data
                    let statusCode = moyaResponse.statusCode
                    
                    guard 200..<300 ~= statusCode else {
                        seal.reject(RemoteAPIError.httpError)
                        return
                    }
                    
                    do {
                        let decoder = JSONDecoder()
                        let forecast = try decoder.decode(SeveralCitiesForecast.self, from: data)
                        seal.fulfill(forecast)
                    } catch let error{
                        seal.reject(RemoteAPIError.parseError(error: error))
                    }
                    
                case .failure(_):
                    seal.reject(RemoteAPIError.unknown)
                }
            }
        }
    }
    
    //TODO: Refeactor the implementation to avoid boilerplate code
    func fiveForecastFor(Location location: Location) -> Promise<FiveForecast> {
        return Promise<FiveForecast> { seal in
            let endPoint = WeatherAPIService.fiveForecastByGeoLocation(latitude: location.latitude, longitude: location.longitude)
            provider.makeWeatherMoyaProvider().request(endPoint) { result in
                switch result {
                case let .success(moyaResponse):
                    let data = moyaResponse.data
                    let statusCode = moyaResponse.statusCode
                    
                    guard 200..<300 ~= statusCode else {
                        seal.reject(RemoteAPIError.httpError)
                        return
                    }
                    
                    do {
                        let decoder = JSONDecoder()
                        let forecast = try decoder.decode(FiveForecast.self, from: data)
                        seal.fulfill(forecast)
                    } catch let error{
                        seal.reject(RemoteAPIError.parseError(error: error))
                    }
                    
                case .failure(_):
                    seal.reject(RemoteAPIError.unknown)
                }
            }
        }
    }
    
    
}
