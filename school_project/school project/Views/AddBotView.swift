//
//  AddBotView.swift
//  school project
//
//  Created by BARTOSIK Patrick on 22/11/2023.
//

import SwiftUI

// Vue pour la sélection des catégories
struct CategorySelectionView: View {
    var difficulty: String

    var body: some View {
        List(QuizCategory.allCases, id: \.self) { category in
            NavigationLink(destination: QuizView(difficulty: difficulty, category: category.rawValue)) {
                Text(category.rawValue)
            }
        }
    }
}

struct AddBotView: View {
    @State private var numberOfBots: Int = 1
    @State private var selectedDifficulty: String = "Débutant"
    @State private var selectedCategory: String = "Histoire"
    let difficulties = ["Noob", "Débutant", "Intermédiaire", "Vétérent", "Puits de savoir"]
    let categories = ["Histoire", "Science", "Mathématiques", "Littérature", "Géographie"]
    @State private var navigateToQuiz = false

    var body: some View {
        NavigationView {
            VStack {
                Spacer()

                Image("addbotview")
                    .resizable()
                    .aspectRatio(contentMode: .fit)

                Spacer()

                Text("Configurez vos adversaires bot")
                    .font(.headline)

                // Number of bots configuration
                Stepper("Nombre de bots: \(numberOfBots)", value: $numberOfBots, in: 1...5)
                    .padding()

                // Difficulty selector
                Picker("Difficulté", selection: $selectedDifficulty) {
                    ForEach(difficulties, id: \.self) { difficulty in
                        Text(difficulty)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()

                // Category selector
                HStack {
                    Text("Sélectionnez votre catégorie : ")
                    Picker("Catégorie", selection: $selectedCategory) {
                        ForEach(categories, id: \.self) { category in
                            Text(category)
                        }
                    }
                    .padding()
                }
                
                Spacer()

                // Navigation button
                Button("Commencer le quiz") {
                    navigateToQuiz = true
                    let quizController = QuizController()
                    quizController.initializeBots(numberOfBots: numberOfBots, difficulty: selectedDifficulty)
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                .padding(.bottom)

                // Navigation link
                NavigationLink("", destination: QuizView(difficulty: selectedDifficulty, category: selectedCategory), isActive: $navigateToQuiz)
                    .hidden()
            }
        }
    }
}

struct AddBotView_Previews: PreviewProvider {
    static var previews: some View {
        AddBotView()
    }
}
