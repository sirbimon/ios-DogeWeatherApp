//
//  Constants.swift
//  MinimalWeatherApp
//
//  Created by Bimonaretga on 12/10/16.
//  Copyright © 2016 devslopes. All rights reserved.
//

import Foundation


let BASE_URL = "http://api.openweathermap.org/data/2.5/weather?"

let LATITUDE = "&lat="
let LONGITUDE = "&lon="
let APP_ID = "&appid="
let API_KEY = "d2829469da9b4a2b6e8829f6fd08ece8"

typealias DownloadComplete = () -> ()

let CURRENT_WEATHER_URL: String = "\(BASE_URL)\(LATITUDE)\(Location.sharedInstance.latitude!)\(LONGITUDE)\(Location.sharedInstance.longitude!)\(APP_ID)\(API_KEY)"


let FORECAST_URL = "http://api.openweathermap.org/data/2.5/forecast/daily?lat=\(Location.sharedInstance.latitude!)&lon=\(Location.sharedInstance.longitude!)&cnt=10&mode=json&appid=d2829469da9b4a2b6e8829f6fd08ece8"

