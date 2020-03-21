//
//  Locator.swift
//  WeatherSearch
//
//  Created by Faris Abu Saleem on 20/03/2020.
//

import Foundation
import PromiseKit

public protocol Locator {
    
    func getCurrentLocation() -> Promise<Location>
}
