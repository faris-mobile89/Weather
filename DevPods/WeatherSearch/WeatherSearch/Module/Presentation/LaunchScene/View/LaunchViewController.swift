//
//  LaunchViewController.swift
//  Pods-Weather
//
//  Created by Faris Abu Saleem on 19/03/2020.
//

import UIKit

class LaunchViewController: ViewController {
    
    let launchViewModelFactory: LaunchViewModelFactory
    
    init(launchViewModelFactory:LaunchViewModelFactory){
        self.launchViewModelFactory = launchViewModelFactory
        super.init()
    }
    
     override func loadView() {
        let viewModel = launchViewModelFactory.makeLaunchViewModel()
        title = "Weather App"
        view = LaunchRootView(viewModel: viewModel)
    }
    
}

protocol LaunchViewModelFactory {
    
    func makeLaunchViewModel() -> LaunchViewModel
}
