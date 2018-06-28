//
//  ViewController.swift
//  foodmatch
//
//  Created by Florian on 6/28/18.
//  Copyright © 2018 com.Florian. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        mapView.showsUserLocation = true
       
        if CLLocationManager.locationServicesEnabled() {
            if CLLocationManager.authorizationStatus() == .restricted || CLLocationManager.authorizationStatus() == .denied || CLLocationManager.authorizationStatus() == .notDetermined {
                
                locationManager.requestWhenInUseAuthorization()
            }
            locationManager.desiredAccuracy = 1.0
            locationManager.delegate = self
            locationManager.startUpdatingLocation()
        } else {
            debugPrint("oups, c'est pété!")
        }
        
    }
    
    //MARK:- CLLocation Manager Delegate
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude
            
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            self.mapView.setRegion(region, animated: true)
    
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Unable to access your current location 👽 ")
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

