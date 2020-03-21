//
//  FakeLocator.swift
//  WeatherSearch
//
//  Created by Faris Abu Saleem on 20/03/2020.
//

import Foundation
import PromiseKit

public class FakeUserLocator: Locator {
    
    // MARK: - Methods
    public init() {}
    
    public func getCurrentLocation() -> Promise<Location> {
        return Promise { seal in
            DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + 2) {
                let location = Location(latitude: 35.94503, longitude: 31.955219)
                seal.fulfill(location)
            }
        }
    }
}
