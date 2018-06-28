//
//  ViewController.swift
//  trainingAlamofire
//
//  Created by Florian on 6/25/18.
//  Copyright © 2018 com.Florian. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {

    @IBOutlet weak var backgroundView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backgroundView.layer.addSublayer(gradientLayer)
    }

    let gradientLayer = CAGradientLayer()
    
    func setBlueGradientBackground() {
        let topColor = UIColor(displayP3Red: 95.0/255.0, green: 165.0/255.0, blue: 1.0, alpha: 1.0).cgColor
        let bottomColor = UIColor(displayP3Red: 112.0/255.0, green: 100.0/255.0, blue: 184.0/255.0, alpha: 1).cgColor
        
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [topColor, bottomColor]
    }
    
    func setRedGradientBackground() {
        let topColor = UIColor(displayP3Red: 165.0/255.0, green: 165.0/255.0, blue: 1.0, alpha: 1.0).cgColor
        let bottomColor = UIColor(displayP3Red: 200.0/255.0, green: 40.0/255.0, blue: 18.0/255.0, alpha: 1).cgColor
        
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [topColor, bottomColor]
    }
    
    func setGreenGradientBackground() {
        let topColor = UIColor(displayP3Red: 165.0/255.0, green: 165.0/255.0, blue: 1.0, alpha: 1.0).cgColor
        let bottomColor = UIColor(displayP3Red: 24.0/255.0, green: 200.0/255.0, blue: 150.0/255.0, alpha: 1).cgColor
        
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [topColor, bottomColor]
    }
    
    @IBAction func buttonPressed(_ sender: AnyObject) {
        switch sender.tag {
        case 1:
            setRedGradientBackground()
        case 2:
            setBlueGradientBackground()
        case 3:
            setGreenGradientBackground()
        default:
            print("pas de bol")
        }
    }
}

