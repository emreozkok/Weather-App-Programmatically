//
//  WeatherAppSwiftTests.swift
//  WeatherAppSwiftTests
//
//  Created by Emre ÖZKÖK on 5.01.2023.
//

import XCTest
@testable import WeatherAppSwift

final class WeatherAppSwiftTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        guard let pathString = Bundle(for: type(of: self)).path(forResource: "weather", ofType: "json") else{
            fatalError("json not found")
        }
        
        guard let json = try? String(contentsOf: URL(filePath: pathString), encoding: .utf8) else{
            fatalError("unable to convert json to string")
        }
       
        let jsonData = json.data(using: .utf8)!
        let weatherData = try JSONDecoder().decode(WeatherData.self, from: jsonData)
        XCTAssertEqual(13.25, weatherData.main.temp)
        XCTAssertEqual("Paris", weatherData.name)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
