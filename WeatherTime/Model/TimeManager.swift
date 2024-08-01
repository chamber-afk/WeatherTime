//
//  TimeDate.swift
//  WeatherTime
//
//  Created by GAURVI SINGHAL on 27/07/24.
//

import Foundation


protocol TimeFetcherDelegate {
    func didFetchTime(_ time: String)
}

let countryTimeZones: [String: String] = [
    "United States": "America/New_York",
    "United Kingdom": "Europe/London",
    "Japan": "Asia/Tokyo",
    "Australia": "Australia/Sydney",
    "India": "Asia/Kolkata"
]


struct TimeFetcher {
    var delegate: TimeFetcherDelegate?
    
    func fetchTime(forCountry countryName: String) {
        DispatchQueue.global().async {
            if let time = currentTime(forCountry: countryName) {
                DispatchQueue.main.async {
                    self.delegate?.didFetchTime(time)
                }
            } else {
                print("Time data not found")
            }
        }
    }
}



func currentTime(forCountry countryName: String) -> String? {
    guard let timeZoneIdentifier = countryTimeZones[countryName] else {
        print("Time zone for \(countryName) not found.")
        return nil
    }
    
    let utcTime = Date()
    let timeZone = TimeZone(identifier: timeZoneIdentifier)
    let dateFormatter = DateFormatter()
    dateFormatter.timeZone = timeZone
    dateFormatter.dateStyle = .medium
    dateFormatter.timeStyle = .medium
    
    let localTimeString = dateFormatter.string(from: utcTime)
    
    return localTimeString
}


