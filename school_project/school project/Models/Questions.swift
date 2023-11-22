//
//  Questions.swift
//  school project
//
//  Created by BARTOSIK Patrick on 22/11/2023.
//

import Foundation

struct QuizQuestion {
    let question: String
    let answers: [String]
    let correctAnswerIndex: Int
    let explain: String
    var userAnswerIndex: Int?
}
