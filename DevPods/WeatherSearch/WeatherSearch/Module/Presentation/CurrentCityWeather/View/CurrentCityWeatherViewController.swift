//
//  CurrentCityWeatherViewController.swift
//  WeatherSearch
//
//  Created by Faris Abu Saleem on 21/03/2020.
//

import UIKit

class CurrentCityWeatherViewController: ViewController, UIAlert {
    
    let currentCityWeatherViewModelFactory: CurrentCityWeatherViewModelFactory
    
    init(currentCityWeatherViewModelFactory:CurrentCityWeatherViewModelFactory){
        self.currentCityWeatherViewModelFactory = currentCityWeatherViewModelFactory
        super.init()
    }
    
    override func loadView() {
        let viewModel = currentCityWeatherViewModelFactory.makeCurrentCityWeatherViewModel()
        title = viewModel.screenTitle
        viewModel.error.observe(on: self) { [weak self] in self?.showError($0) }
        view = CurrentCityWeatherRootView(viewModel: viewModel)
    }
    
    func showError(_ error: String) {
        guard !error.isEmpty else { return }
        showAlert(title: "Error", message: error)
    }
    
}

protocol CurrentCityWeatherViewModelFactory {
    
    func makeCurrentCityWeatherViewModel() -> CurrentCityWeatherViewModel
}
