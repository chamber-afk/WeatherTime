//
//  TimeDate.swift
//  WeatherTime
//
//  Created by GAURVI SINGHAL on 27/07/24.
//

import Foundation


protocol TimeFetcherDelegate {
    func didFetchTime(_ timeManager : TimeManager,_ time: String)
}

import Foundation


struct TimeManager {
    var delegate: TimeFetcherDelegate?
    
    func fetchTime(forCountry countryName: String) {
        DispatchQueue.global().async {
            if let time = currentTime(forCountry: countryName) {
                DispatchQueue.main.async {
                    self.delegate?.didFetchTime(self, time)
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

//MARK: - Countries data for time

let countryTimeZones: [String: String] = [

    "United States": "America/New_York",
    "Canada": "America/Toronto",
    "United Kingdom": "Europe/London",
    "Germany": "Europe/Berlin",
    "France": "Europe/Paris",
    " ": "Asia/Tokyo",
    "Australia": "Australia/Sydney",
    "India": "Asia/Kolkata",
    "China": "Asia/Shanghai",
    "Brazil": "America/Sao_Paulo",
    "Mexico": "America/Mexico_City",
    "South Africa": "Africa/Johannesburg",
    "Russia": "Europe/Moscow",
    "Argentina": "America/Argentina/Buenos_Aires",
    "Italy": "Europe/Rome",
    "Spain": "Europe/Madrid",
    "Netherlands": "Europe/Amsterdam",
    "Sweden": "Europe/Stockholm",
    "Norway": "Europe/Oslo",
    "Denmark": "Europe/Copenhagen",
    "Switzerland": "Europe/Zurich",
    "Austria": "Europe/Vienna",
    "Belgium": "Europe/Brussels",
    "Turkey": "Europe/Istanbul",
    "Saudi Arabia": "Asia/Riyadh",
    "United Arab Emirates": "Asia/Dubai",
    "Israel": "Asia/Jerusalem",
    "New Zealand": "Pacific/Auckland",
    "South Korea": "Asia/Seoul",
    "Singapore": "Asia/Singapore",
    "Malaysia": "Asia/Kuala_Lumpur",
    "Thailand": "Asia/Bangkok",
    "Vietnam": "Asia/Ho_Chi_Minh",
    "Philippines": "Asia/Manila",
    "Indonesia": "Asia/Jakarta",
    "Pakistan": "Asia/Karachi",
    "Bangladesh": "Asia/Dhaka",
    "Nepal": "Asia/Kathmandu",
    "Sri Lanka": "Asia/Colombo",
    "Iran": "Asia/Tehran",
    "Iraq": "Asia/Baghdad",
    "Jordan": "Asia/Amman",
    "Lebanon": "Asia/Beirut",
    "Kuwait": "Asia/Kuwait",
    "Qatar": "Asia/Qatar",
    "Oman": "Asia/Muscat",
    "Yemen": "Asia/Aden",
    "Libya": "Africa/Tripoli",
    "Nigeria": "Africa/Lagos",
    "Kenya": "Africa/Nairobi",
    "Ghana": "Africa/Accra",
    "Uganda": "Africa/Kampala",
    "Zimbabwe": "Africa/Harare",
    "Zambia": "Africa/Lusaka",
    "Ethiopia": "Africa/Addis_Ababa",
    "Morocco": "Africa/Casablanca",
    "Algeria": "Africa/Algiers",
    "Tunisia": "Africa/Tunis",
    "Mali": "Africa/Bamako",
    "Senegal": "Africa/Dakar",
    "Ivory Coast": "Africa/Abidjan",
    "Chad": "Africa/Ndjamena",
    "Central African Republic": "Africa/Bangui",
    "Cameroon": "Africa/Douala",
    "Somalia": "Africa/Mogadishu",
    "South Sudan": "Africa/Juba",
    "Burundi": "Africa/Bujumbura",
    "Rwanda": "Africa/Kigali",
    "Congo": "Africa/Brazzaville",
    "Congo (Democratic Republic)": "Africa/Kinshasa",
    "Mauritius": "Indian/Mauritius",
    "Seychelles": "Indian/Mahe",
    "Malawi": "Africa/Blantyre",
    "Botswana": "Africa/Gaborone",
    "Lesotho": "Africa/Maseru",
    "Eswatini": "Africa/Mbabane",
    "Suriname": "America/Paramaribo",
    "Guyana": "America/Guyana",
    "Belize": "America/Belize",
    "Honduras": "America/Tegucigalpa",
    "Guatemala": "America/Guatemala",
    "El Salvador": "America/El_Salvador",
    "Costa Rica": "America/Costa_Rica",
    "Panama": "America/Panama",
    "Cuba": "America/Havana",
    "Dominican Republic": "America/Santo_Domingo",
    "Jamaica": "America/Jamaica",
    "Trinidad and Tobago": "America/Port_of_Spain",
    "Barbados": "America/Barbados",
    "Grenada": "America/Grenada",
    "Saint Lucia": "America/St_Lucia",
    "Saint Vincent and the Grenadines": "America/St_Vincent",
    "Antigua and Barbuda": "America/Antigua",
    "Saint Kitts and Nevis": "America/St_Kitts",
    "Saint Pierre and Miquelon": "America/Miquelon",
    "Bermuda": "Atlantic/Bermuda",
    "Falkland Islands": "Atlantic/Stanley",
    "Greenland": "America/Thule",
    "Faroe Islands": "Atlantic/Faroe",
    "Andorra": "Europe/Andorra",
    "San Marino": "Europe/San_Marino",
    "Monaco": "Europe/Monaco",
    "Liechtenstein": "Europe/Vaduz",
    "Vatican City": "Europe/Vatican",
    "Palestine": "Asia/Gaza",
    "Western Sahara": "Africa/El_Aaiun",
    "Mauritania": "Africa/Nouakchott",
    "South Georgia and the South Sandwich Islands": "Atlantic/South_Georgia",
    "Montserrat": "America/Montserrat"
]

