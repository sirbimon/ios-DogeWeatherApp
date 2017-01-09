//
//  MainVC.swift
//  MinimalWeatherApp
//
//  Created by Bimonaretga on 12/7/16.
//  Copyright © 2016 devslopes. All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation

class MainVC: UIViewController, UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var WindSpeedLabel: UILabel!
    @IBOutlet weak var TableView: UITableView!
    @IBOutlet weak var CurrentWeatherLabel: UILabel!
    @IBOutlet weak var currentWeatherImage: UIImageView!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var borderOne: UIView!
    
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation!

    
    
    
    //object instantiation:
    
    var currentWeather = CurrentWeather() //instantiated the necessary object to operate and display the data.
    var forecast: Forecast!
    var forecasts = [Forecast]()  //instantiated the object array of type Forecast
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()

        TableView.delegate = self
        TableView.dataSource = self
        

        
        

        
    }
    
    func locationAuthStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            currentLocation = locationManager.location
            
            //print("\(currentLocation.coordinate.longitude), \(currentLocation.coordinate.latitude)")
            Location.sharedInstance.latitude = currentLocation.coordinate.latitude
            Location.sharedInstance.longitude = currentLocation.coordinate.longitude
            print("\(currentLocation.coordinate.longitude), \(currentLocation.coordinate.latitude)")
            
            currentWeather.downloadWeatherDetails {
                self.downloadForecastData{
                    self.updateMainUI()
                }
            }
            
        } else {
            locationManager.requestWhenInUseAuthorization()
            locationAuthStatus()
            

            
        }
    }
    
    @IBAction func buttonPressed(_ sender: Any) {
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationAuthStatus()
    }
    

    
    func downloadForecastData(completed: @escaping DownloadComplete) {
        Alamofire.request(FORECAST_URL).responseJSON { response in
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject> {
                
                if let list = dict["list"] as? [Dictionary<String, AnyObject>] {
                    
                    for obj in list {
                        let forecast = Forecast(weatherDict: obj)
                        self.forecasts.append(forecast)
                        //print(obj)
                    }
                    self.forecasts.remove(at: 0)
                    self.TableView.reloadData()
                }

            }
            completed()
        }
        
    }


    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecasts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as? WeatherCell {
            
            let forecast = forecasts[indexPath.row]
            cell.configureCell(forecast: forecast)
            return cell
        } else {
            return WeatherCell()
        }
        
       
    }
    
    func updateMainUI() {
        dateLabel.text = currentWeather.date
        currentTempLabel.text = "\(Int(currentWeather.currentTemp))°"
        CurrentWeatherLabel.text = "\(currentWeather.currentWeatherType) \nDay"
        locationLabel.text = currentWeather.cityName
        WindSpeedLabel.text = "\(Int(currentWeather.windSpeed)) km/h"
        currentWeatherImage.image = UIImage(named: currentWeather.currentWeatherType)
        
        
    }
}

