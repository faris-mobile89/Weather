//
//  DateTimeTests.swift
//  WeatherSearch-Unit-Tests
//
//  Created by Faris Abu Saleem on 20/03/2020.
//

import XCTest

class DateTimeTests: XCTestCase {
    
    func testDateTimeFormatter(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateTime = dateFormatter.date(from: "2020-03-20 18:00:00")!
        XCTAssertNotNil(dateTime)
    }
    
    func testDateFormatter(){
        let dateTimeFormatter = DateFormatter()
        dateTimeFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateTime = dateTimeFormatter.date(from: "2020-03-20 18:00:00")!
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let date = dateFormatter.string(from: dateTime)
        XCTAssertNotNil(date)
        XCTAssertEqual(date, "2020-03-20")
    }
    
}
