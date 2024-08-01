//
//  WeatherData.swift
//  WeatherTime
//
//  Created by GAURVI SINGHAL on 24/07/24.
//

import Foundation

struct WeatherData : Codable {
    let name: String
    let main: Main
    let weather: [Weather]
    let timezone: Int
}

struct Main : Codable {
    let temp : Double
}

struct Weather: Codable {
    let description: String
    let id: Int
}
