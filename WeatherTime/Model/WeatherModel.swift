//
//  WeatherModel.swift
//  WeatherTime
//
//  Created by GAURVI SINGHAL on 24/07/24.
//

import Foundation

struct WeatherModel {
    let conditionId : Int
    let cityName : String
    let temperature : Double
    let timezone : Int
    
    var temperatureString : String {
        return String(format: "%.1f", temperature)
    }
    
    var timezoneString : String {
        let utcNow = Date()
        let localDate = utcNow.addingTimeInterval(TimeInterval(timezone))
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
        formatter.timeZone = TimeZone(secondsFromGMT: timezone)
        return formatter.string(from: localDate)
    }
    
    var conditionName : String {                                            
        switch conditionId {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        }
    }
}
