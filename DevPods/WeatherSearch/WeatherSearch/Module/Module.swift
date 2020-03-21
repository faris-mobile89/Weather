//
//  Module.swift
//  WeatherSearch
//
//  Created by Faris Abu Saleem on 19/03/2020.
//

import Foundation

public struct ModuleDependencies {

    public init(){
        
    }
}


public struct Module {

    private let diContainer: DependencyInjectionContainer
    
    public init(dependencies: ModuleDependencies) {
        self.diContainer = DependencyInjectionContainer(dependencies: dependencies)
    }
    

    public func startWeatherSearch() -> UIViewController {
        return diContainer.makeLaunchViewController()
    }
    
    public func setRootController(navigationController:UINavigationController){
        diContainer.setRootController(navigationController: navigationController)
    }
    
}


public protocol ChatPresenter {
    func openChatForUser(inView: UIViewController)
}
