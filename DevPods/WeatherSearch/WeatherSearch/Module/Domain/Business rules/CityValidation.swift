//
//  CityValidation.swift
//  WeatherSearch
//
//  Created by Faris Abu Saleem on 20/03/2020.
//

import Foundation

final class CityValidation {
    
    private let inputs:[String]
    
    init(inputs:[String]){
        self.inputs = inputs
    }
    
    /**
    Validates list of inputs.

    - Throws: `CityInputError.empty`
              if `input` is "empty".

    - Returns: true if the input is valid.
    */
    func validate() throws -> Bool {
        guard !inputs.isEmpty else {throw CityInputError.empty}
        guard inputs.count >= 3 else { throw CityInputError.insufficient}
        guard inputs.count <= 7 else { throw CityInputError.overflow}
        return true
    }
}


enum CityInputError:Error {
       case empty
       case insufficient
       case overflow
}
