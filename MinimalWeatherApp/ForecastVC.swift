//
//  ForecastVC.swift
//  MinimalWeatherApp
//
//  Created by Bimonaretga on 12/18/16.
//  Copyright © 2016 devslopes. All rights reserved.
//

import UIKit
import Alamofire

class ForecastVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var forecast: Forecast!
    var forecasts = [Forecast]()
    
    @IBOutlet weak var TableViewForecast: UITableView!
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
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
    override func viewDidLoad() {
        super.viewDidLoad()

        
        TableViewForecast.delegate = self
        TableViewForecast.dataSource = self
        
        downloadForecastData{
            print("abs")
        }
        
        
    }
    
    
    func downloadForecastData(completed: @escaping DownloadComplete) {
        Alamofire.request(FORECAST_URL).responseJSON { response in
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject> {
                
                if let list = dict["list"] as? [Dictionary<String, AnyObject>] {
                    
                    for obj in list {
                        let forecast = Forecast(weatherDict: obj)
                        self.forecasts.append(forecast)
                        print(obj)
                    }
                    self.forecasts.remove(at: 0)
                    self.TableViewForecast.reloadData()
                }
                
            }
            completed()
        }
        
    }
    
    @IBAction func buttonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

}
