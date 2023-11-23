//
//  GameModeSelectionView.swift
//  school project
//
//  Created by BARTOSIK Patrick on 20/11/2023.
//

import SwiftUI

// Énumération pour les modes de jeu
enum GameMode {
    case solo, multiWithBots
}

struct GameModeSelectionView: View {
    @State private var selectedMode: GameMode?
    @State private var showDifficultyOptions = false
    @State private var selectedDifficulty: String?
    @State private var showCategorySelection = false
    @State private var isLoading = false
    @State private var loadedQuestions: [QuizQuestion] = []
    @State private var showAddBotView = false
    @EnvironmentObject var quizController: QuizController

    var body: some View {
        VStack {
            // Section Choix du Mode de Jeu
            if !showDifficultyOptions && !showCategorySelection && !showAddBotView {
                chooseGameModeSection
            }
            
            // Afficher AddBotView si showAddBotView est activé
            if showAddBotView {
                AddBotView()
            }

            // Section Difficulté
            if showDifficultyOptions && !showCategorySelection {
                DifficultySelectionView(selectedMode: selectedMode, showCategorySelection: $showCategorySelection, selectedDifficulty: $selectedDifficulty)
            }

            // Section Catégorie
            if showCategorySelection {
                CategorySelectionView(difficulty: selectedDifficulty ?? "")
            }
        }
        .padding()
    }

    // Vue pour la sélection du mode de jeu
    var chooseGameModeSection: some View {
        VStack {
            Text("Choisissez votre mode de jeu")
                .font(.headline)
                .padding()

            HStack {
                gameModeButton(imageName: "modeSolo", buttonText: "Je m'entraine") {
                    selectedMode = .solo
                    showDifficultyOptions = true
                }

                gameModeButton(imageName: "modeMulti", buttonText: "Seul conte des bots") {
                    selectedMode = .multiWithBots
                    showAddBotView = true
                }
            }
        }
    }

    // Bouton pour choisir le mode de jeu
    func gameModeButton(imageName: String, buttonText: String, action: @escaping () -> Void) -> some View {
        VStack {
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding()

            Button(buttonText, action: action)
                .buttonStyle(.borderedProminent)
        }
    }
}

struct GameModeSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        GameModeSelectionView()
            .environmentObject(QuizController())
    }
}
