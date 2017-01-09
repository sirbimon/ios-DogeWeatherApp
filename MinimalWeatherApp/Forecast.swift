//
//  Forecast.swift
//  MinimalWeatherApp
//
//  Created by Bimonaretga on 12/11/16.
//  Copyright © 2016 devslopes. All rights reserved.
//

import UIKit
import Alamofire

class Forecast {
    
    var _date: String!
    var _hiTemp: Double!
    var _lowTemp: Double!
    var _weatherType: String!
    
    var date: String {
        if _date == nil {
            _date = ""
        }
        return _date
    }
    
    var hiTemp: Double {
        if _hiTemp == nil {
            _hiTemp = 0.0
        }
        return _hiTemp
    }
    
    var lowTemp: Double {
        if _lowTemp == nil {
            _lowTemp = 0.0
        }
        return _lowTemp
    }
    
    var weatherType: String {
        if _weatherType == nil{
            _weatherType = ""
        }
        return _weatherType
    }
    
    
    init(weatherDict: Dictionary<String, AnyObject>) {
        
        //now we have an array containing the dictionary download from JSON
        
        if let temp = weatherDict["temp"] /*cast it*/ as? Dictionary<String, AnyObject> {
            
            if let min = temp["min"] as? Double {
                
                let kelvinToCelcius = min - 273.15
                
                self._lowTemp = kelvinToCelcius
            }
            
            if let max = temp["max"] as? Double {
                
                let kelvinToCelcius = max - 273.15
                
                self._hiTemp = kelvinToCelcius
            }
            
        }
        
        if let weather = weatherDict["weather"] as? [Dictionary<String, AnyObject>] {
            
            if let main = weather[0]["main"] as? String {
                self._weatherType = main
            }
        }
        
        if let date = weatherDict["dt"] as? Double {
            let unixConvertedDate = Date(timeIntervalSince1970: date)
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .full
            dateFormatter.timeStyle = .none
            dateFormatter.dateFormat = "EEEE"
            self._date = unixConvertedDate.dayOfTheWeek()
        }
        
    }
    
}


//write extension date

extension Date {
    func dayOfTheWeek() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self)
}

}
