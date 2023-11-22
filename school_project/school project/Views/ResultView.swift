//
//  ResultView.swift
//  school project
//
//  Created by BARTOSIK Patrick on 21/11/2023.
//

import SwiftUI

struct ResultView: View {
    var questions: [QuizQuestion]
    var averageTimePerQuestion: Double
    var botScores: [Int]

    var body: some View {
        ScrollView {
            VStack {
                Text("Résultats du Quiz")
                Text("Votre scord est de : \(calculateScore()) / 10")
                    .padding()
                Text("Temps moyen par question: \(String(format: "%.2f", averageTimePerQuestion)) secondes")
                    .padding()
                
                ForEach(0..<questions.count, id: \.self) { index in
                    let question = questions[index]
                    let isCorrect = question.correctAnswerIndex == question.userAnswerIndex
                    let userAnswer = question.userAnswerIndex != nil ? question.answers[question.userAnswerIndex!] : "Non répondu"
                    let correctAnswer = question.answers[question.correctAnswerIndex]
                    let explain = question.explain

                    VStack(alignment: .leading, spacing: 10) {
                        Text(question.question)
                            .fontWeight(.bold)
                        Text("Votre réponse: \(userAnswer)")
                            .padding()
                            .border(isCorrect ? Color.green : Color.red, width: 2)
                        if !isCorrect {
                            Text("Bonne réponse: \(correctAnswer)")
                                .padding()
                                .border(Color.green, width: 2)
                        }
                        
                        Text("Explication: \(explain)")
                            .padding()
                    }
                    .padding()
                    
                    if !botScores.isEmpty {
                        Text("Scores des Bots")
                            .fontWeight(.bold)
                        ForEach(botScores.indices, id: \.self) { index in
                            Text("Bot \(index + 1): \(botScores[index]) points")
                        }
                    }

                }
            }
        }
    }

    private func calculateScore() -> Int {
        let correctAnswers = questions.filter { $0.correctAnswerIndex == $0.userAnswerIndex }.count
        return correctAnswers
    }
}

struct ResultView_Previews: PreviewProvider {
    static var previews: some View {
        ResultView(questions: [
            QuizQuestion(question: "Quelle est la capitale de la France ?", answers: ["Paris", "Lyon", "Marseille", "Bordeaux"], correctAnswerIndex: 0, explain: "Paris est la capitale de la France.", userAnswerIndex: 1),
            QuizQuestion(question: "Qui a peint la Joconde ?", answers: ["Vincent Van Gogh", "Pablo Picasso", "Leonardo Da Vinci", "Claude Monet"], correctAnswerIndex: 2, explain: "La Joconde a été peinte par Leonardo Da Vinci.", userAnswerIndex: 2)
        ], averageTimePerQuestion: 5.0, botScores: [3, 4, 5])
    }
}
