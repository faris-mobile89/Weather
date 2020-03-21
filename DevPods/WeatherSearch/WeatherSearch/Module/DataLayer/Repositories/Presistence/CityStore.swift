//
//  CityStore.swift
//  WeatherSearch
//
//  Created by Faris Abu Saleem on 19/03/2020.
//

import Foundation


protocol CityStore {
    
    /// Returns city
    ///
    /// - Parameters:
    ///     - name: The *Name* of city
    func fetch(city name: String) -> City?
    
    
    /// Returns list of cities
    ///
    /// - Parameters:
    ///     - name: The *Name* of city
    func fetch(cities names:[String]) -> [City]
    
}
