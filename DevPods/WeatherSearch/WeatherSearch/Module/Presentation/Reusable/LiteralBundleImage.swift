//
//  LiteralBundleImage.swift
//  WeatherSearch
//
//  Created by Faris Abu Saleem on 21/03/2020.
//

import Foundation

final class LiteralBundleImage: _ExpressibleByImageLiteral {
    let image: UIImage?
    
    required init(imageLiteralResourceName name: String) {
        image = UIImage(named: name, in: Bundle(for: Self.self).bundleResource, compatibleWith: nil)
    }
}
