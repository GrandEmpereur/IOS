//
//  Question.swift
//  school project
//
//  Created by BARTOSIK Patrick on 20/11/2023.
//

import Foundation

struct QuizQuestion {
    let question: String
    let answers: [String]
    let correctAnswerIndex: Int
}


let sampleQuestions: [QuizQuestion] = [
    QuizQuestion(
        question: "Quelle est la capitale de la France ?",
        answers: ["Paris", "Lyon", "Marseille", "Bordeaux"],
        correctAnswerIndex: 0
    ),
    QuizQuestion(
        question: "Qui a peint la Joconde ?",
        answers: ["Vincent Van Gogh", "Pablo Picasso", "Leonardo Da Vinci", "Claude Monet"],
        correctAnswerIndex: 2
    ),
    // Ajoutez d'autres questions ici
]
