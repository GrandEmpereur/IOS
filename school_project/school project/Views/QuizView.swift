//
//  QuizView.swift
//  school project
//
//  Created by BARTOSIK Patrick on 21/11/2023.
//

import SwiftUI

struct QuizView: View {
    var difficulty: String
    var category: String
    @StateObject var quizController = QuizController()
    @State private var showResultView = false

    var body: some View {
        VStack {
            if quizController.isLoading {
                LoadingView()
            } else if quizController.questions.isEmpty {
                Text("Aucune question disponible.")
            } else {
                    // Barre supérieure avec difficulté et catégorie
                    HStack {
                        Text("Difficulté: \(difficulty)")
                        Spacer()
                        Text("Catégorie: \(category)")
                    }
                    .padding()
                    .background(Color.gray.opacity(0.2))

                    // Numéro de question et timer
                    HStack {
                        Text("Question \(quizController.currentQuestionIndex + 1)/\(quizController.questions.count)")
                        Spacer()
                        Text("Temps: \(quizController.timeRemaining)s")
                    }
                    .padding()

                    Spacer()

                    // Affichage de la question
                    Text(quizController.questions[quizController.currentQuestionIndex].question)
                        .font(.title)
                        .multilineTextAlignment(.center)
                        .padding()

                    Spacer()

                    // Affichage des réponses
                    if !quizController.isQuizCompleted {
                        responseButtonsGrid
                    } else {
                        let botScores = quizController.bots.map { $0.score }
                        Button("Voir les Résultats") {
                            showResultView = true
                        }
                        .sheet(isPresented: $showResultView) {
                            ResultView(questions: quizController.questions, averageTimePerQuestion: quizController.averageTimePerQuestion, botScores: botScores)
                        }
                    }
                    
                Spacer()
            }
        }
        .navigationBarBackButtonHidden()
        .onAppear {
            quizController.loadQuestions(category: category, difficulty: difficulty)
        }
        .padding()
        .navigationBarTitle("", displayMode: .inline)
    }

    // Grille pour les réponses
    var responseButtonsGrid: some View {
        VStack(spacing: 15) {
            ForEach(0..<2) { row in
                HStack(spacing: 15) {
                    ForEach(0..<2) { column in
                        let index = row * 2 + column
                        Button(action: {
                            quizController.submitAnswer(at: index)
                        }) {
                            Text(quizController.questions[quizController.currentQuestionIndex].answers[index])
                                .padding()
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .background(Color.blue.opacity(0.2))
                                .cornerRadius(10)
                        }
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: 200)
    }
}

struct QuizView_Previews: PreviewProvider {
    static var previews: some View {
        QuizView(difficulty: "Débutant", category: "Histoire")
    }
}


