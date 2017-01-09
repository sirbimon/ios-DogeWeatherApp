//
//  CurrentWeather.swift
//  MinimalWeatherApp
//
//  Created by Bimonaretga on 12/10/16.
//  Copyright © 2016 devslopes. All rights reserved.
//

import Alamofire
import UIKit

class CurrentWeather {
    
    var _cityName: String!
    var _date: String!
    var _currentWeatherType: String!
    var _currentTemp: Double!
    var _windSpeed: Double!
    var _windChill: Double!
    
    var windChill: Double {
        if _windChill == nil {
            _windChill = 0.0
        }
        return _windChill
    }
    
    var windSpeed: Double {
        if _windSpeed == nil {
            _windSpeed = 0.0
        }
        return _windSpeed
    }
    
    var cityName: String {
        if _cityName == nil {
            _cityName = ""
        }
        return _cityName
    }
    
    var date: String {
        if _date == nil {
            _date = ""
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        let currentDate = dateFormatter.string(from: Date())
        self._date = "Today, \(currentDate)"
        return _date
    }
    
    var currentWeatherType: String {
        if _currentWeatherType == nil {
            _currentWeatherType = ""
        }
        return _currentWeatherType
    }
    
    var currentTemp: Double {
        if _currentTemp == nil {
            _currentTemp = 0.0 //because it's a double.
        }
        return _currentTemp
    }
    
    func downloadWeatherDetails(completed: @escaping DownloadComplete) {
        //AlamoFire download
        let currentWeatherURL = CURRENT_WEATHER_URL
        print("\(currentWeatherURL)")

        Alamofire.request(currentWeatherURL).responseJSON { response in
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject> {
                if let name = dict["name"] as? String {
                    self._cityName = name.capitalized
                    print(self._cityName)
                }
                
                
                if let weather = dict["weather"] as? [Dictionary<String, AnyObject>] {
                    if let main = weather[0]["main"] as? String {
                        self._currentWeatherType = main.capitalized
                        print(self._currentWeatherType)

                        }
                    }
                if let main = dict["main"] as? Dictionary<String, AnyObject> {
                    if let currentTemperatur = main["temp"] as? Double {
                     let kelvinToCelcius = currentTemperatur - 273.15
                     
                        self._currentTemp = kelvinToCelcius
                        print(self._currentTemp)
                        }
                    }
                if let wind = dict["wind"] as? Dictionary<String, AnyObject> {
                    if let CurrentWindSpeed = wind["speed"] as? Double {
                        let kmhWindspeed = CurrentWindSpeed / 0.2778
                        self._windSpeed = kmhWindspeed
                    }
                }
            }
            completed()
        }
        

    }
}


