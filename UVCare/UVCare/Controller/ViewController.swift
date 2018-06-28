//
//  ViewController.swift
//  UVCare
//
//  Created by Florian on 6/22/18.
//  Copyright © 2018 com.Florian. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var dangerLevel: UILabel!
    @IBOutlet weak var tipsLabel: UILabel!
    @IBOutlet weak var levelProtectIcon: UIImageView!
    @IBOutlet weak var hatIcon: UIImageView!
    @IBOutlet weak var glassesIcon: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    
    //Constants
    let url = "http://api.openweathermap.org/data/2.5/uvi?"
    let APP_ID = "d34243423424324324342432"
    
    //Instances Variables
    let locationManager = CLLocationManager()
    let weatherDataModel = WeatherDataModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set up the location manager.
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
    }

    
    //MARK: - Networking
    /********************************************************************/
    func getWeatherData(url: String, parameters: [String: String]) {
        
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON {
            response in
            if response.result.isSuccess {
                
                print("Success! Got the weather data")
                let weatherJSON : JSON = JSON(response.result.value!)
                
                
                print(weatherJSON)
                
                self.updateWeatherData(json: weatherJSON)
                
            }
            else {
                print("Error \(String(describing: response.result.error))")
                self.cityLabel.text = "Connection Issues"
            }
        }
        
    }
    
    //MARK: - JSON Parsing
    /***************************************************************/
    func updateWeatherData(json: JSON) {
        let uVValue = json["value"].doubleValue
        //weatherDataModel.city = json["name"].stringValue
        weatherDataModel.uvIndex = Int(uVValue)
    }
    
    //MARK: - UI Update
    /***************************************************************/

    
    
    //MARK: - Location Manager Delegate Methods
    /***************************************************************/
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[locations.count - 1]
        if location.horizontalAccuracy > 0 {
            self.locationManager.stopUpdatingLocation()
            
            print("longitude = \(location.coordinate.longitude), Latitude = \(location.coordinate.latitude)")
            
            let latitude = String(location.coordinate.latitude)
            let longitude = String(location.coordinate.longitude)
            
            let params : [String : String] = ["lat" : latitude, "lon" : longitude, "appid" : APP_ID]
            
            getWeatherData(url: url, parameters: params)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}




