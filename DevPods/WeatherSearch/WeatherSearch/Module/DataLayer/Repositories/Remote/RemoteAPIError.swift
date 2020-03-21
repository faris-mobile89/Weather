//
//  RemoteAPIError.swift
//  WeatherSearch
//
//  Created by Faris Abu Saleem on 19/03/2020.
//

import Foundation

enum RemoteAPIError: Error {
    case unknown
    case httpError
    case parseError(error:Error)
}
