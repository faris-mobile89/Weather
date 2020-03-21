//
//  Bundle.swift
//  WeatherSearch
//
//  Created by Faris Abu Saleem on 21/03/2020.
//

import Foundation

extension Bundle {
    var bundleResource: Bundle {
        // static framework
        if let resourceURL = resourceURL,
            let resourceBundle = Bundle(url: resourceURL.appendingPathComponent(ModuleName.name + ".bundle")) {
            return resourceBundle
        } else {
            // dynamic framework
            return self
        }
    }
}

private struct ModuleName {
    static var name: String = {
        String(reflecting: ModuleName.self).components(separatedBy: ".").first ?? ""
    }()
}
