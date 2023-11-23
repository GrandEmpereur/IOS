//
//  AddBotView.swift
//  school project
//
//  Created by BARTOSIK Patrick on 22/11/2023.
//

import SwiftUI

struct AddBotView: View {
    @State private var numberOfBots: Int = 1
    @State private var selectedDifficulty: String = "Débutant"
    @State private var selectedCategory: String = "Histoire"
    let difficulties = ["Noob", "Débutant", "Intermédiaire", "Vétérent", "Puits de savoir"]
    @State private var navigateToQuiz = false
    @EnvironmentObject var quizController: QuizController

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
                        ForEach(QuizCategory.allCases, id: \.self) { category in
                            Text(category.rawValue).tag(category.rawValue)
                        }
                    }
                    .padding()
                }
                
                Spacer()

                // Navigation button
                Button("Commencer le quiz") {
                    quizController.initializeBots(numberOfBots: numberOfBots, difficulty: selectedDifficulty)
                    navigateToQuiz = true
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                .padding(.bottom)

                // Navigation link
                NavigationLink("", destination: QuizView(difficulty: selectedDifficulty, category: selectedCategory).environmentObject(quizController), isActive: $navigateToQuiz)
            }
        }
    }
}

struct AddBotView_Previews: PreviewProvider {
    static var previews: some View {
        AddBotView()
            .environmentObject(QuizController())
    }
}
