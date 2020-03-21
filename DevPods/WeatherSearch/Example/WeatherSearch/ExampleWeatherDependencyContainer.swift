//
//  ExampleWeatherDependencyContainer.swift
//  WeatherSearch_Example
//
//  Created by Faris Abu Saleem on 20/03/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import WeatherSearch

public class ExampleWeatherDependencyContainer {
    
    
    // MARK: - Modules of Features
    
    lazy var weatherSearchModule: WeatherSearch.Module = {
        let dependencies = WeatherSearch.ModuleDependencies()
        return WeatherSearch.Module(dependencies: dependencies)
    }()
    
    // MARK: - Methods
    public init() {
        
    }
    
}
