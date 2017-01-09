//
//  Location.swift
//  MinimalWeatherApp
//
//  Created by Bimonaretga on 12/14/16.
//  Copyright © 2016 devslopes. All rights reserved.
//

import CoreLocation

class Location {
    static var sharedInstance = Location()
    
    private init() {}
    
    var latitude: Double!
    var longitude: Double!
    
}
