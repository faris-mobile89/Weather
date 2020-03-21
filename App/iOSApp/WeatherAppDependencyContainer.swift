//
//  WeatherAppDependencyContainer.swift
//  App
//
//  Created by Faris Abu Saleem on 19/03/2020.
//  Copyright © 2020 Faris Abu Saleem. All rights reserved.
//

import Foundation
import WeatherSearch
import UIKit

public class WeatherAppDependencyContainer {
    
    //MARK: - Modules of Features
    lazy var weatherSearchModule: WeatherSearch.Module = {
      let dependencies = WeatherSearch.ModuleDependencies()
      return WeatherSearch.Module(dependencies: dependencies)
  }()

  // MARK: - Methods
  public init() {
    
    
  }
  
}
