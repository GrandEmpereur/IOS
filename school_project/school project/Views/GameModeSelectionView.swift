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

    var body: some View {
        VStack {
            // Section Choix du Mode de Jeu
            if !showDifficultyOptions && !showCategorySelection {
                chooseGameModeSection
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
                    showDifficultyOptions = true
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

// Vue pour la sélection de la difficulté
struct DifficultySelectionView: View {
    var selectedMode: GameMode?
    @Binding var showCategorySelection: Bool
    @Binding var selectedDifficulty: String?

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {

                DifficultyCard(
                    imageName: "logo",
                    level: "Noob",
                    description: "Plongez dans l'univers du quiz avec des questions simples et ludiques. Idéal pour les débutants !",
                    action: {
                        selectedDifficulty = "Noob"
                        showCategorySelection = true
                    }
                )

                DifficultyCard(
                    imageName: "logo",
                    level: "Débutant",
                    description: "Défiez-vous avec des questions légèrement plus complexes. Un pas de plus vers l'expertise !",
                    action: {
                        selectedDifficulty = "Débutant"
                        showCategorySelection = true
                    }
                )
                
                DifficultyCard(
                    imageName: "logo",
                    level: "Intermédiaire",
                    description: "Préparez-vous à des questions corsées. Pour ceux qui aiment les défis sérieux !",
                    action: {
                        selectedDifficulty = "Intermédiaire"
                        showCategorySelection = true
                    }
                )
                
                DifficultyCard(
                    imageName: "logo",
                    level: "Vétérent",
                    description: "Questions de haut niveau pour les experts. Seuls les meilleurs réussiront !",
                    action: {
                        selectedDifficulty = "Vétérent"
                        showCategorySelection = true
                    }
                )
                
                DifficultyCard(
                    imageName: "logo",
                    level: "Puis de savoir",
                    description: "Le sommet du quiz. Pour les maîtres incontestés du savoir et de la réflexion.",
                    action: {
                        selectedDifficulty = "Puis de savoir"
                        showCategorySelection = true
                    }
                )
            }
            .padding()
        }
    }
}

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


struct DifficultyCard: View {
    var imageName: String
    var level: String
    var description: String
    var action: () -> Void

    var body: some View {
        VStack {
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(height: 150)
            Text(level)
                .font(.headline)
            Text(description)
                .font(.caption)
                .padding()
            Button(action: action) {
                Text("Choisir")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 5)
    }
}

struct GameModeSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        GameModeSelectionView()
    }
}

