//
//  DependencyInjectionContainer.swift
//  WeatherSearch
//
//  Created by Faris Abu Saleem on 19/03/2020.
//

import Foundation
import Moya

final class DependencyInjectionContainer {
    
    private let dependencies: ModuleDependencies
    
    private lazy var launchNavigator:LaunchNavigator = {
        makeLaunchNavigator()
    }()
    
    var root:UINavigationController?
    
    init(dependencies: ModuleDependencies) {
        self.dependencies = dependencies
    }
    
    func makeLaunchNavigator() -> LaunchNavigator{
        return LaunchNavigator(dependencyInjectionContainer: self)
    }
    
    func makeLocator() -> Locator{
        UserCurrentCityLocator()
    }
    
    // MARK: - Use Cases
    
    func makeSeveralCitiesForecastUseCase() -> SearchSeveralCitiesForecastUseCase{
        DefaultSearchCitiesForecastUseCase(forecastRepository: makeWeatherRepository(),
                                           cityStore: makeCityStore())
    }
    
    func makeCurrentCityWeatherLocatorUseCase()-> CurrentCityWeatherLocatorUseCase{
        DefaultCurrentCityWeatherLocatorUseCase(locator: makeLocator())
    }
    
    func makeFetchCityFiveForecastByLocationUseCase() -> FetchCityFiveForecastByLocationUseCase{
        DefaultFetchCityFiveForecastByLocationUseCase(locatorUseCase: makeCurrentCityWeatherLocatorUseCase(), forecastRepository: makeWeatherRepository())
    }
    
    //MARK: - Repositories
    
    func makeWeatherRepository() -> ForecastsRepository {
        let provider = DefaultWeatherMoyaProvider()
        let forecastRemoteAPI = CloudWeatherRemoteAPI(provider: provider)
        return DefaultForecastRepository(remoteAPI: forecastRemoteAPI)
    }
    
    func makeCityStore() -> CityStore{
        return CityDataStoreDisk()
    }
    
    //MARK: - Scene
    
    //MARK:  Launch Scene
    func makeLaunchViewController() -> UIViewController{
        return LaunchViewController(launchViewModelFactory: self)
    }
    
    //MARK:  Search Scene
    func makeWeatherSearchViewController() -> UIViewController{
        return SearchWeatherViewController(searchWeatherViewModelFactory: self)
    }
    
    //MARK:  Current City Scene
    func makeCurrentCityWeatherViewController() -> UIViewController{
        return CurrentCityWeatherViewController(currentCityWeatherViewModelFactory: self)
    }
    
    //MARK: - View Models
    
    func makeLaunchViewModel() -> LaunchViewModel{
        return LaunchViewModel(goToSearchNavigator: launchNavigator, goToLocatorNavigator: launchNavigator)
    }
    
    func makeSearchWeatherViewModel() -> SearchWeatherViewModel {
        DefaultSearchWeatherViewModel(searchForecastUseCase: makeSeveralCitiesForecastUseCase())
    }
    
    func setRootController(navigationController:UINavigationController){
        root = navigationController
    }
    
    func makeSearchDetailsViewModel(title: String, forecast: SeveralCitiesForecast) -> SearchDetailsViewController {
        SearchDetailsViewController(viewModel: makeSearchDetailsViewModel(title: title, forecast: forecast))
    }
    
    func makeSearchDetailsViewModel(title: String, forecast: SeveralCitiesForecast) -> SearchDetailsViewModel {
        return DefaultSearchDetailsViewModel(title: title, forecast: forecast)
    }
    
    func makeCurrentCityWeatherViewModel() -> CurrentCityWeatherViewModel {
        DefaultCurrentCityWeatherViewModel(fetchCityFiveForecastByLocationUseCase: makeFetchCityFiveForecastByLocationUseCase())
    }
    
}


//MARK:- Factory
extension DependencyInjectionContainer: LaunchViewModelFactory, SearchWeatherViewModelFactory, CurrentCityWeatherViewModelFactory { }

