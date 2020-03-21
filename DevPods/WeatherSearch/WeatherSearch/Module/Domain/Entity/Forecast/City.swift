//
//  City.swift
//  WeatherSearch
//
//  Created by Faris Abu Saleem on 19/03/2020.
//

import Foundation

struct City: Codable {
    let id:Int
    let name, country: String?
    var state:String?
    
    init(id:Int, name:String) {
        self.id = id
        self.name = name
        self.country = nil
        self.state = nil
    }
}
