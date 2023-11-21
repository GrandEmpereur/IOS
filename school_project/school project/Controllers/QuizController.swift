//
//  QuizController.swift
//  school project
//
//  Created by BARTOSIK Patrick on 20/11/2023.
//

import Foundation

class QuizController: ObservableObject {
    @Published var questions: [QuizQuestion] = []
        @Published var currentQuestionIndex = 0
        @Published var selectedAnswerIndex: Int?
        @Published var isAnswerCorrect: Bool?
        @Published var timeRemaining = 30
        @Published var timer: Timer?
        @Published var isQuizCompleted = false
        @Published var correctAnswersCount = 0

        func loadQuestions(category: String, difficulty: String) {
            APIManager.shared.fetchQuizQuestions(category: category, difficulty: difficulty) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let loadedQuestions):
                        self.questions = loadedQuestions
                    case .failure(let error):
                        print("Erreur de chargement des questions : \(error)")
                        // Vous pouvez gérer l'erreur comme vous le souhaitez ici
                    }
                }
            }
        }
    
    func fetchQuestions(category: String, difficulty: String) {
            APIManager.shared.fetchQuizQuestions(category: category, difficulty: difficulty) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let questions):
                        self.questions = questions
                        self.currentQuestionIndex = 0 // Réinitialiser l'indice de question
                        self.correctAnswersCount = 0 // Réinitialiser le compteur de réponses correctes
                        print("Questions reçues : \(questions)")
                        self.startTimer() // Redémarrer le timer pour la nouvelle série de questions
                    case .failure(let error):
                        print("Erreur : \(error)")
                    }
                }
            }
        }

    func submitAnswer(at index: Int) {
        
        selectedAnswerIndex = index
        isAnswerCorrect = index == questions[currentQuestionIndex].correctAnswerIndex
        if index == questions[currentQuestionIndex].correctAnswerIndex {
            correctAnswersCount += 1
        }
        nextQuestion()
    }

    func nextQuestion() {
        if currentQuestionIndex < questions.count - 1 {
            currentQuestionIndex += 1
            resetTimer()
        } else {
            isQuizCompleted = true
            timer?.invalidate()
        }
    }

    func startTimer() {
        timer?.invalidate() // Arrête le timer précédent si nécessaire
        timeRemaining = 30
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            self?.timeRemaining -= 1
            if self?.timeRemaining == 0 {
                self?.nextQuestion()
            }
        }
    }

    func resetTimer() {
        timer?.invalidate()
        timeRemaining = 30
        startTimer()
    }
}
