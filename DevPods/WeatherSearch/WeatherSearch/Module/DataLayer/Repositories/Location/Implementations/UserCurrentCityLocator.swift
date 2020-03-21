//
//  UserCityLocator.swift
//  WeatherSearch
//
//  Created by Faris Abu Saleem on 21/03/2020.
//

import Foundation
import CoreLocation
import PromiseKit

public class UserCurrentCityLocator: Locator {
    
    public func getCurrentLocation() -> Promise<Location> {
        return CLLocationManager.requestLocation().lastValue.then { location -> Promise<Location> in
            return .value(Location(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude))
        }
    }
    
}
