//
//  WeatherManager.swift
//  WeatherTime
//
//  Created by GAURVI SINGHAL on 23/07/24.
//

import Foundation
import UIKit

protocol WeatherManagerDelegate {
    func didUpdateWather(_ weatherManager : WeatherManager,weather: WeatherModel)
}

struct WeatherManager {
    
    var delegate : WeatherManagerDelegate?
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=73a43a89349c7ef2ba4cc96986730acf&units=metric"
    
    func fetchWeather(cityName : String){
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString : String){
        if let url = URL(string: urlString){
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil{
                    print(error!)
                    return
                }
                
                if let safeData = data {
                    if let weather =  self.parseJSON(safeData){
                        self.delegate?.didUpdateWather(self, weather: weather)
                    }
                }
            }
            
            task.resume()
        }
    }
    
    func parseJSON(_ weatherData : Data) -> WeatherModel?{
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let temp = decodedData.main.temp
            let id = decodedData.weather[0].id
            let name = decodedData.name
            let time = decodedData.timezone
            
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp, timezone: time)

            return weather
        } catch {
            print(error)
            return  nil
        }
    }
    

    
}
