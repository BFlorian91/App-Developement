//
//  ViewController.swift
//  uvtry
//
//  Created by Florian on 6/27/18.
//  Copyright © 2018 com.Florian. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var uvlabel: UILabel!
    @IBOutlet weak var uvView: UIView!
    @IBOutlet weak var dangerLabel: UILabel!
    
    let url = "http://api.openweathermap.org/data/2.5/uvi?"
    let API_KEY = "d73937eca684ab25d1f516dba202a37c"


    let uvData = UVData()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        uvView.layer.cornerRadius = 20
        weatherData(url: url, param: ["lat": 48.60, "lon" : 3.50, "appid" : API_KEY])
    }
 
    func weatherData(url: String, param: [String : Any]) {
        Alamofire.request(url, method: .get, parameters: param).responseJSON { (response) in
            if response.result.isSuccess {
                let uvJSON : JSON = JSON(response.result.value!)

                self.updateWeatherData(json: uvJSON)
                print(uvJSON)
            } else if response.result.isFailure {
                print("Oupss!")
            }
        }
    }
    
    func updateWeatherData(json : JSON) {
        
        let uvVal = json["value"].intValue
        uvData.uvValue = uvVal
        
        updateUIWithDangerColor()
    }

    
    func updateUIWithDangerColor() {
        
        switch uvData.uvValue {
        case 1...2:
            dangerLabel.textColor = UIColor.green
            dangerLabel.text = "Low"
            uvlabel.textColor = UIColor.green
            uvlabel.text = "\(uvData.uvValue)"
        case 3...5:
            dangerLabel.textColor = UIColor.yellow
            dangerLabel.text = "Moderate"
            uvlabel.textColor = UIColor.yellow
            uvlabel.text = "\(uvData.uvValue)"
        case 6...7:
            dangerLabel.textColor = UIColor.orange
            dangerLabel.text = "Hight"
            uvlabel.textColor = UIColor.orange
            uvlabel.text = "\(uvData.uvValue)"
        case 8...11:
            dangerLabel.textColor = UIColor.red
            dangerLabel.text = "Very Hight"
            uvlabel.textColor = UIColor.red
            uvlabel.text = "\(uvData.uvValue)"
        case 11...100:
            dangerLabel.textColor = UIColor.purple
            dangerLabel.text = "Extrem"
            uvlabel.textColor = UIColor.purple
            uvlabel.text = "\(uvData.uvValue)"
        default:
            print("value error!")
        }
        
    }

}

