//
//  ViewController.swift
//  Magic 8 Ball
//
//  Created by Florian on 6/9/18.
//  Copyright © 2018 com.Florian. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    var randomAnswersIndex : Int = 0
    
    let ballImageArray = ["ball1", "ball2", "ball3", "ball4", "ball5"]
    
    @IBOutlet weak var ballViewImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
            ballViewImage.image = UIImage(named: "ball1")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func askButtonPressed(_ sender: UIButton) {
        updateImageBall()
    }
    func updateImageBall() {
        randomAnswersIndex = Int(arc4random_uniform(5))
        ballViewImage.image = UIImage(named: ballImageArray[randomAnswersIndex])
    }
    
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        updateImageBall()
    }
}

