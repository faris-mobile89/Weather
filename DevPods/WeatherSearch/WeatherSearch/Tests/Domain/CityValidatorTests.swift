//
//  CityValidatorTests.swift
//  WeatherSearch-Unit-Tests
//
//  Created by Faris Abu Saleem on 20/03/2020.
//

import XCTest
@testable import WeatherSearch

class CityValidatorTests: XCTestCase {
    
    func testEmptyInputs(){
        let inputs:[String] = []
        let validator = CityValidation(inputs: inputs)
        do{
            let isValid = try validator.validate()
             XCTAssertFalse(isValid)
        }catch let error{
           XCTAssertEqual(error as? CityInputError , CityInputError.empty)
        }
    }
    
    func testOverflow(){
        let inputs:[String] = ["Dubai", "Ajman", "RAK", "Abu Dhabi", "Sharjah", "Mardif", "UMM Quwain", "Al Ain"]
        let validator = CityValidation(inputs: inputs)
        do{
            let isValid = try validator.validate()
            XCTAssertFalse(isValid)
        }catch let error{
            XCTAssertEqual(error as? CityInputError , CityInputError.overflow)
        }
    }
    
    func testInsufficient(){
        let inputs:[String] = ["Dubai", "Sharjah"]
        let validator = CityValidation(inputs: inputs)
        do{
            let isValid = try validator.validate()
            XCTAssertFalse(isValid)
        }catch let error{
            XCTAssertEqual(error as? CityInputError , CityInputError.insufficient)
        }
    }
    
    func testValidInput(){
        let inputs:[String] = ["Dubai", "Sharjah", "Abu Dhabi"]
        let validator = CityValidation(inputs: inputs)
        do{
            let isValid = try validator.validate()
            XCTAssertTrue(isValid)
        }catch{
            XCTFail()
        }
    }
}
