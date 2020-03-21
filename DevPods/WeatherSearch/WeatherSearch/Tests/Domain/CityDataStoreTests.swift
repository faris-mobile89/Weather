//
//  CityDataStoreTests.swift
//  WeatherSearch-Unit-Tests
//
//  Created by Faris Abu Saleem on 19/03/2020.
//

import XCTest
@testable import WeatherSearch

class CityDataStoreTests: XCTestCase {
    
    func testLocalCitiesJsonFileExists(){
        if let path = Bundle(for: type(of: self)).path(forResource: "city.list", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                XCTAssertNotNil(data)
            } catch let error {
                XCTFail("parse error")
                print("parse error: \(error.localizedDescription)")
            }
        } else {
            XCTFail("json file not found")
        }
    }
    
    func testLocalCitiesDataStore(){
        let datastore = CityDataStoreDisk()
        let result = datastore.fetch(city: "Dubai")
        XCTAssertNotNil(result)
        XCTAssertEqual(result?.name, "Dubai")
        XCTAssertEqual(result?.id, 292223)
    }
    
    func testLocalCitiesDataStore_WithMultipleCities(){
        let datastore = CityDataStoreDisk()
        let citites = ["Dubai", "Amman", "London"]
        let results = datastore.fetch(cities: citites)
        XCTAssertNotNil(results)
        XCTAssertEqual(results.count, 3)
    }
    
}
