//
//  Question.swift
//  Quizzler
//
//  Created by Florian on 6/13/18.
//  Copyright © 2018 com.Florian. All rights reserved.
//

import Foundation

class Question {
    let questionText : String
    let answer : Bool
    
    init(text: String, correctAnswer: Bool) {
        questionText = text
        answer = correctAnswer
    }
    
}
