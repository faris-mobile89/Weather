//
//  Location.swift
//  WeatherSearch
//
//  Created by Faris Abu Saleem on 20/03/2020.
//

import Foundation


public typealias Latitude = Double
public typealias Longitude = Double

public struct Location: Codable {
    
    public internal(set) var latitude: Latitude
    public internal(set) var longitude: Longitude
    
    public init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
    
}
