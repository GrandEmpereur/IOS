//
//  QuizController.swift
//  school project
//
//  Created by BARTOSIK Patrick on 20/11/2023.
//

import Foundation

struct Bot {
    let id: UUID
    var score: Int
    var difficultyLevel: String
    
    // Générer une réponse aléatoire
    func generateRandomAnswer(for question: QuizQuestion) -> Int {
        // Implémentez la logique en fonction du niveau de difficulté du bot
        return Int.random(in: 0..<question.answers.count)
    }
}

class QuizController: ObservableObject {
    @Published var questions: [QuizQuestion] = []
    @Published var currentQuestionIndex = 0
    @Published var selectedAnswerIndex: Int?
    @Published var isAnswerCorrect: Bool?
    @Published var timeRemaining = 30
    @Published var timer: Timer?
    @Published var isQuizCompleted = false
    @Published var correctAnswersCount = 0
    @Published var isLoading = false
    @Published var totalElapsedTime = 0
    @Published var averageTimePerQuestion: Double = 0.0
    var bots: [Bot] = []

    // CALL API A CHAT GPT
    func loadQuestions(category: String, difficulty: String) {
        isLoading = true
        APIManager.shared.fetchQuizQuestions(category: category, difficulty: difficulty) { result in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let loadedQuestions):
                    self.questions = loadedQuestions
                    self.currentQuestionIndex = 0 // Réinitialiser l'indice de question
                    self.correctAnswersCount = 0 // Réinitialiser le compteur de réponses correctes
                    self.startTimer() // Redémarrer le timer pour la nouvelle série de questions
                case .failure(let error):
                    print("Erreur de chargement des questions : \(error)")
                }
            }
        }
    }
    
    // GESTION DES QUESTION
    func submitAnswer(at index: Int) {
        selectedAnswerIndex = index
        questions[currentQuestionIndex].userAnswerIndex = index
        isAnswerCorrect = index == questions[currentQuestionIndex].correctAnswerIndex
        if index == questions[currentQuestionIndex].correctAnswerIndex {
            correctAnswersCount += 1
        }
        updateElapsedTime()
        nextQuestion()
    }
    
    private func updateElapsedTime() {
        // Mettre à jour le temps total
        totalElapsedTime += (30 - timeRemaining)
        // Calculer le temps moyen par question
        averageTimePerQuestion = Double(totalElapsedTime) / Double(currentQuestionIndex + 1)
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

    // GESTION DU TEMPS ET DU TIMER
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
    
    // GESTION DES BOT
    func initializeBots(numberOfBots: Int, difficulty: String) {
        bots = (0..<numberOfBots).map { _ in
            Bot(id: UUID(), score: 0, difficultyLevel: difficulty)
        }
    }
    
    func handleBotResponses(currentQuestion: QuizQuestion) {
        for index in bots.indices {
            let botAnswer = bots[index].generateRandomAnswer(for: currentQuestion)
            if botAnswer == currentQuestion.correctAnswerIndex {
                bots[index].score += 1 // Augmenter le score si la réponse est correcte
            }
        }
    }

}
