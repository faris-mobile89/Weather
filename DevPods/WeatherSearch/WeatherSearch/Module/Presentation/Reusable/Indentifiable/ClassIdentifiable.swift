//
//  ClassIdentifiable.swift
//  WeatherSearch
//
//  Created by Faris Abu Saleem 22.07.18.
//  Copyright © 2019 Faris Abu Saleem. All rights reserved.
//

import UIKit

protocol ClassIdentifiable: class {
    static var reuseId: String { get }
}

extension ClassIdentifiable {
    static var reuseId: String {
        return String(describing: self)
    }
}

protocol ViewIdentifiable: NibIdentifiable, ClassIdentifiable {}
