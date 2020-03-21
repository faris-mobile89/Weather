//
//  AppDelegate.swift
//  App
//
//  Created by Faris Abu Saleem on 19/03/2020..
//  Copyright © 2020 Faris Abu Saleem. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    let injectionContainer = WeatherAppDependencyContainer()
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

