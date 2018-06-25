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
    let APP_ID = "d73937eca684ab25d1f516dba202a37c"
    
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
    func updateUIWithWeatherData() {
       // cityLabel.text = weatherDataModel.city
        dangerLevel.text = String(weatherDataModel.uvIndex)
    }
    
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















//
//[{"lat":37.75,"lon":-122.37,
//    "date_iso":"2017-06-27T12:00:00Z",
//    "date":1498564800,"value":10.1},
//
// {"lat":37.75,"lon":-122.37,
//    "date_iso":"2017-06-28T12:00:00Z",
//    "date":1498651200,"value":10.19},
//
// {"lat":37.75,"lon":-122.37,
//    "date_iso":"2017-06-29T12:00:00Z",
//    "date":1498737600,"value":10.2},
//
// {"lat":37.75,"lon":-122.37,
//    "date_iso":"2017-06-30T12:00:00Z",
//    "date":1498824000,
//    "value":9.01},
//
// {"lat":37.75,"lon":-122.37,
//    "date_iso":"2017-07-01T12:00:00Z",
//    "date":1498910400,"value":9.46},
//
// {"lat":37.75,"lon":-122.37,
//    "date_iso":"2017-07-02T12:00:00Z",
//    "date":1498996800,"value":10.16},
//
// {"lat":37.75,"lon":-122.37,
//    "date_iso":"2017-07-03T12:00:00Z",
//    "date":1499083200,"value":9.85},
//
// {"lat":37.75,"lon":-122.37,
//    "date_iso":"2017-07-04T12:00:00Z",
//    "date":1499169600,"value":10.05}]

