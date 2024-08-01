//
//  ViewController.swift
//  WeatherTime
//
//  Created by GAURVI SINGHAL on 23/07/24.
//

import UIKit

class MainViewController: UIViewController , UITextFieldDelegate, WeatherManagerDelegate, FlagManagerDelegate, TimeFetcherDelegate{
   
    
    
    
    var weatherManager = WeatherManager()
    
    var flagManager = FlagManager()
    
    var timeManager = TimeManager()
    
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var conditionLabel: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBAction func searchPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
    }
    @IBOutlet weak var searchTextField: UITextField!
    
    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet weak var flagImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //view.backgroundColor = UIColor.white
        flagManager.delegate = self
        weatherManager.delegate = self
        timeManager.delegate = self
        searchTextField.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if searchTextField.text != "" {
            return true
        }else {
            searchTextField.placeholder = "Type Something"
            return false
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let city = searchTextField.text {
            weatherManager.fetchWeather(cityName: city)
            flagManager.fetchCityName(cityName: city)
            timeManager.fetchTime(forCountry: city)
        }
        searchTextField.text = ""
    }
    
    func didUpdateWather(_ weatherManager : WeatherManager,weather: WeatherModel) {
        DispatchQueue.main.sync {
            self.temperatureLabel.text = weather.temperatureString
            self.conditionLabel.image = UIImage(systemName: weather.conditionName)
            self.cityLabel.text = weather.cityName
            self.backgroundImage.image = UIImage(named: weather.conditionName)
            
        }
    }
    
    func didUpadateFlag(_ flagManager : FlagManager,flag : FlagModel){
        DispatchQueue.global().async {
            if let imageData = try? Data(contentsOf: flag.FlagImg){
                DispatchQueue.main.async {
                    self.flagImage.image = UIImage(data: imageData)
                }
            }
        }
    }
    
    func didFetchTime(_ timeManager: TimeManager, _ time: String) {
        dateTimeLabel.text = time
    }
    
}

