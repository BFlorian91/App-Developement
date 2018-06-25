//
//  ViewController.swift
//  trainingGeoLocal
//
//  Created by Florian on 6/24/18.
//  Copyright © 2018 com.Florian. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var localisationLabel: UILabel!
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    @IBOutlet weak var viewContainer: UIView!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        // If location services is enabled get the users location
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    @IBAction func updateLocationButton(_ sender: UIButton) {
        locationManager.startUpdatingLocation()
    }
    
    // Print out the location to the console && in the Labels
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            
            let latitude = String(location.coordinate.latitude)
            let longitude = String(location.coordinate.longitude)
            
            latitudeLabel.text = latitude
            longitudeLabel.text = longitude
            
            print(latitude + "\n" + longitude)
            locationManager.stopUpdatingLocation()
            
            
            viewContainer.layer.cornerRadius = 10
        }
    }
    
    
    // If we have been deined access give the user the option to change it
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if(status == CLAuthorizationStatus.denied) {
            showLocationDisablePopUp()
        }
    }
    
    
    // Show the popup to user if the location access was denied
    func showLocationDisablePopUp() {
        let alertController = UIAlertController(title: "Background Location Access Disabled",
                                                message: "We need your Location",
                                                preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)


        let openAction = UIAlertAction(title: "Open Settings", style: .default) { (action) in
            if let url = URL(string: UIApplicationOpenSettingsURLString) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        alertController.addAction(openAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
}

