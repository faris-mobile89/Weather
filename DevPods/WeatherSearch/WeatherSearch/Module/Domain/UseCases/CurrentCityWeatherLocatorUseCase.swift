//
//  CurrentCityLocatorUseCase.swift
//  WeatherSearch
//
//  Created by Faris Abu Saleem on 20/03/2020.
//

import Foundation
import PromiseKit

protocol CurrentCityWeatherLocatorUseCase {
    
    func execute() -> Promise<Location>
}

final class DefaultCurrentCityWeatherLocatorUseCase: CurrentCityWeatherLocatorUseCase{
    
    let locator: Locator
    
    init(locator: Locator){
        self.locator = locator
    }
    
    func execute() -> Promise<Location> {
        locator.getCurrentLocation()
    }
}
