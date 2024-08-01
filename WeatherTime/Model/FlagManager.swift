//
//  FlagManager.swift
//  WeatherTime
//
//  Created by GAURVI SINGHAL on 25/07/24.
//

import Foundation

protocol FlagManagerDelegate{
    func didUpadateFlag(_ flagManager : FlagManager,flag : FlagModel)
}

struct FlagManager {
    
    var delegate : FlagManagerDelegate?
    
    let flagUrl = "https://restcountries.com/v3.1/name"
    
    func fetchCityName(cityName: String) {
        let urlString = "\(flagUrl)/\(cityName)"
        performRequest(with: urlString)
    }

    
    func performRequest (with urlString : String){
        if let url = URL(string: urlString) {
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    print(error!)
                    return
                }
                if let safeData = data {
                    if let flag =  self.parseJSON(safeData){
                        delegate?.didUpadateFlag(self, flag: flag)
                    }
                    
                }
            }
            task.resume()
        }
    }
    
    
    func parseJSON(_ flagData: Data) -> FlagModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode([FlagData].self, from: flagData)
            
            if let firstFlagData = decodedData.first, let pngURL = firstFlagData.flags["png"] {
                let imageUrl = URL(string : pngURL)!
                
                let flag = FlagModel(FlagImg: imageUrl)
                return flag
            }
            else {
                return nil
            }
        } catch {
            print("Error decoding JSON: \(error)")
            return nil
        }
    }


   
}
