//
//  APIManager.swift
//  school project
//
//  Created by BARTOSIK Patrick on 20/11/2023.
//  
//
import Foundation

extension String {
    func matches(_ regex: String) -> Bool {
        return self.range(of: regex, options: .regularExpression) != nil
    }
}

    class APIManager {
        static let shared = APIManager()

        private init() {}

        func fetchQuizQuestions(category: String, difficulty: String, completion: @escaping (Result<[QuizQuestion], Error>) -> Void) {
            let url = URL(string: "https://api.openai.com/v1/chat/completions")!
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.addValue("Bearer key", forHTTPHeaderField: "Authorization")
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")

            let prompt = "Generate 10 quiz questions with four multiple choice answers each and give me the correct one for each questions, in the category of \(category) and difficulty level \(difficulty)."
            let body: [String: Any] = [
                "model": "gpt-3.5-turbo",
                "messages": [
                    ["role": "system", "content": "You are a helpful assistant."],
                    ["role": "user", "content": prompt]
                ]
            ]

            request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])

            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }

                guard let data = data,
                      let jsonResponse = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                      let choices = jsonResponse["choices"] as? [[String: Any]],
                      let firstChoice = choices.first,
                      let message = firstChoice["message"] as? [String: Any],
                      let content = message["content"] as? String else {
                    completion(.failure(URLError(.cannotParseResponse)))
                    return
                }

                let quizQuestions = self.parseQuizQuestions(from: content)
                completion(.success(quizQuestions))
            }.resume()
        }

        private func parseQuizQuestions(from content: String) -> [QuizQuestion] {
            var questions: [QuizQuestion] = []
            var currentQuestion: String?
            var currentAnswers: [String] = []
            var correctAnswer: String?

            let lines = content.split(separator: "\n").map(String.init)

            for line in lines {
                if line.trimmingCharacters(in: .whitespaces).matches("^\\d+\\.\\s.*") {
                    // Nouvelle question commence
                    if let question = currentQuestion, let correctAnswer = correctAnswer, !currentAnswers.isEmpty {
                        let correctAnswerIndex = currentAnswers.firstIndex(of: correctAnswer) ?? 0
                        questions.append(QuizQuestion(question: question, answers: currentAnswers, correctAnswerIndex: correctAnswerIndex))
                        currentAnswers.removeAll()
                    }
                    currentQuestion = line
                } else if line.trimmingCharacters(in: .whitespaces).hasPrefix("a)") ||
                          line.trimmingCharacters(in: .whitespaces).hasPrefix("b)") ||
                          line.trimmingCharacters(in: .whitespaces).hasPrefix("c)") ||
                          line.trimmingCharacters(in: .whitespaces).hasPrefix("d)") {
                    currentAnswers.append(line.trimmingCharacters(in: .whitespaces))
                } else if line.contains("Correct answer:") {
                    correctAnswer = line.components(separatedBy: ":").last?.trimmingCharacters(in: .whitespaces)
                }
            }

            // Ajouter la dernière question si elle existe
            if let question = currentQuestion, let correctAnswer = correctAnswer, !currentAnswers.isEmpty {
                let correctAnswerIndex = currentAnswers.firstIndex(of: correctAnswer) ?? 0
                questions.append(QuizQuestion(question: question, answers: currentAnswers, correctAnswerIndex: correctAnswerIndex))
            }

            return questions
        }


    }
