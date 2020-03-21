//
//  LaunchViewModel.swift
//  WeatherSearch
//
//  Created by Faris Abu Saleem on 20/03/2020.
//

import Foundation

class LaunchViewModel{
    
    let goToSearchNavigator: GoToSearchNavigator
    let goToLocatorNavigator: GoToLocatorNavigator
    
    init(goToSearchNavigator: GoToSearchNavigator,
         goToLocatorNavigator: GoToLocatorNavigator) {
        self.goToSearchNavigator = goToSearchNavigator
        self.goToLocatorNavigator = goToLocatorNavigator
    }
    
    
    @objc
    public func showSearchWeatherView() {
        goToSearchNavigator.navigateToSearch()
    }
    
    @objc
    public func showCurrentCityView() {
        goToLocatorNavigator.navigateToLocator()
    }
    
}
