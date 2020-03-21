//
//  CityDataStoreDisk.swift
//  WeatherSearch
//
//  Created by Faris Abu Saleem on 19/03/2020.
//

import Foundation

class CityDataStoreDisk: CityStore {
   
    let cities:[City]
    
    init() {
        if let path = Bundle(for: type(of: self)).path(forResource: "city.list", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let decoder = JSONDecoder()
                self.cities = try decoder.decode([City].self, from: data)
            } catch {
                cities = []
            }
        } else {
            cities = []
        }
    }
    
    
    /// Complexity
    /// O(n), where n is the length of the sequence.
    /// Search city by name
    func fetch(city name: String) -> City? {
        //TODO: Need to be optimized
        guard !cities.isEmpty else {
            return nil
        }
        let cityName = name.lowercased()
        return cities.first{
            $0.name?.lowercased() == cityName
        }
    }
    
    func fetch(cities names: [String]) -> [City] {
        guard !names.isEmpty else {
            return []
        }
        
        var result:[City] = []
        
        for cityName in names{
            guard let city = fetch(city: cityName) else {continue}
            result.append(city)
        }
        return result
    }
}
