//
//  LaunchNavigator.swift
//  WeatherSearch
//
//  Created by Faris Abu Saleem on 20/03/2020.
//

import Foundation

final class LaunchNavigator: GoToSearchNavigator, GoToLocatorNavigator {
    
    private let diContainer:DependencyInjectionContainer
        
    init(dependencyInjectionContainer:DependencyInjectionContainer) {
        self.diContainer = dependencyInjectionContainer
    }
    
    func navigateToSearch() {
        let controller = diContainer.makeWeatherSearchViewController()
        diContainer.root?.pushViewController(controller, animated: true)
    }
    
    func navigateToLocator() {
        let controller = diContainer.makeCurrentCityWeatherViewController()
        diContainer.root?.pushViewController(controller, animated: true)
    }
}
