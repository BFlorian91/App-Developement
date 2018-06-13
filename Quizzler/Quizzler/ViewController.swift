//
//  ViewController.swift
//  Quizzler
//
//  Created by Florian on 25/08/2015.
//  Copyright © 2018 com.Florian. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //initialisation Data
    let allQuestions = QuestionBank()
    //Récupère la value de la réponse
    var pickedAnswer : Bool = false
    //Compteur de questions
    var questionNumber : Int = 0
    //Score
    var score : Int = 0
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var progressBar: UIView!
    @IBOutlet weak var progressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nextQuestion()
    }


    @IBAction func answerPressed(_ sender: AnyObject) {
        //Si le button qui a le tag 1 est pressé l'utilisateur appuie donc sur le button true
        if sender.tag == 1 {
            pickedAnswer = true
        } else if sender.tag == 2 {
            pickedAnswer = false
        }
        //Une fois que l'utilisateur à touch sur le button on check si la reponse est good
        checkAnswer()
        
        questionNumber += 1
        nextQuestion()
        
        
    }
    func updateUI() {
        scoreLabel.text = "Score: \(score)"
        progressLabel.text = "\(questionNumber + 1) / 13"
        
        progressBar.frame.size.width = (view.frame.size.width / 13) * CGFloat(questionNumber + 1)
    }
    

    func nextQuestion() {
        if questionNumber <= 12 {
            questionLabel.text = allQuestions.list[questionNumber].questionText
            
            updateUI()
        } else {
            let alert = UIAlertController(title: "Awesome", message: "You've finished all the questions, do you want start over?", preferredStyle: .alert)
            
            let restartAction = UIAlertAction(title: "Restart", style: .default, handler: { (UIAlertAction) in
                self.startOver()
                
            })
            
            alert.addAction(restartAction)
            
            present(alert, animated: true, completion: nil)
        }
    }
    
    
    func checkAnswer() {
        //creation d'une var qui check si c'est la bonne rep
        let correctAnswer = allQuestions.list[questionNumber].answer
        
        //debug
        if correctAnswer == pickedAnswer {
            ProgressHUD.showSuccess("Correct")
            score += 1
        } else {
            ProgressHUD.showError("Wrong!")
        }
    }
    
    
    func startOver() {
        questionNumber = 0
        nextQuestion()
    }
    

    
}
