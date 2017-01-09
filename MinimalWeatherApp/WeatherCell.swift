//
//  WeatherCell.swift
//  MinimalWeatherApp
//
//  Created by Bimonaretga on 12/13/16.
//  Copyright © 2016 devslopes. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {
    
    
    @IBOutlet weak var weatherType: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var hiTemp: UILabel!
    @IBOutlet weak var lowTemp: UILabel!
    
    
//write a function to configure those iboutlets to work with the downloaded data.
    
    func configureCell(forecast: Forecast) {
        lowTemp.text = "\(round(forecast.lowTemp))"
        hiTemp.text = "\(round(forecast.hiTemp))"
        weatherType.text = forecast.weatherType
        dayLabel.text = forecast.date
        weatherIcon.image = UIImage(named: forecast.weatherType)
        
    }
}
