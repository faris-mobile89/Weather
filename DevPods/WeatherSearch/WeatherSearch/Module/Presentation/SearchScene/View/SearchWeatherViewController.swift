//
//  SearchWeatherViewController.swift
//  WeatherSearch
//
//  Created by Faris Abu Saleem on 21/03/2020.
//

import UIKit

class SearchWeatherViewController: ViewController, UIAlert {
    
    let searchWeatherViewModelFactory: SearchWeatherViewModelFactory
    
    init(searchWeatherViewModelFactory:SearchWeatherViewModelFactory){
        self.searchWeatherViewModelFactory = searchWeatherViewModelFactory
        super.init()
    }
    
    override func loadView() {
        let viewModel = searchWeatherViewModelFactory.makeSearchWeatherViewModel()
        title = viewModel.screenTitle
        viewModel.error.observe(on: self) { [weak self] in self?.showError($0) }
        viewModel.route.observe(on: self) { [weak self] in self?.handle($0) }
        view = SearchWeatherRootView(viewModel: viewModel)
        hideKeyboardWhenViewTapped()
    }
    
    func showError(_ error: String) {
        guard !error.isEmpty else { return }
        showAlert(title: "Error", message: error)
    }
}

// MARK: - Handle Search Routing

extension SearchWeatherViewController {
    func handle (_ route: SearchWeatherViewModelRoute){
        switch route {
        case .initial:
            break
        case .showSearchWeatherDetail(let title, let forecast):
            let controller = searchWeatherViewModelFactory.makeSearchDetailsViewModel(title: title, forecast: forecast)
            navigationController?.pushViewController(controller, animated: true)
        }
    }
}

protocol SearchWeatherViewModelFactory {
    
    func makeSearchWeatherViewModel() -> SearchWeatherViewModel
    func makeSearchDetailsViewModel(title: String, forecast: SeveralCitiesForecast) -> SearchDetailsViewController
}
