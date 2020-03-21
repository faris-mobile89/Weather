//
//  AppDelegate.swift
//  WeatherSearch
//
//  Created by faris.it.cs@gmail.com on 03/18/2020.
//  Copyright (c) 2020 faris.it.cs@gmail.com. All rights reserved.
//

import UIKit
import WeatherSearch

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    let injectionContainer = ExampleWeatherDependencyContainer()
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let mainVC = injectionContainer.weatherSearchModule.startWeatherSearch()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        

        let root = UINavigationController(rootViewController: mainVC)
        injectionContainer.weatherSearchModule.setRootController(navigationController: root)
        window?.rootViewController = root
        window?.makeKeyAndVisible()
        
        return true
    }

}

