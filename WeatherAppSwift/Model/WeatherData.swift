//
//  WeatherData.swift
//  WeatherAppSwift
//
//  Created by Emre ÖZKÖK on 3.01.2023.
//

import Foundation
struct WeatherData: Codable{
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Codable{
    let temp: Double
}

struct Weather: Codable{
    let id: Int
    let description: String
}
