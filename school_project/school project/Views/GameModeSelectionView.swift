//
//  GameModeSelectionView.swift
//  school project
//
//  Created by BARTOSIK Patrick on 20/11/2023.
//

import SwiftUI

struct GameModeSelectionView: View {
    @State private var selectedMode: GameMode?
    @State private var showDifficultyOptions = false

    var body: some View {
        VStack {
            if showDifficultyOptions {
                // Vue pour la sélection de la difficulté
                DifficultySelectionView(selectedMode: selectedMode)
            } else {
                // Vue pour la sélection du mode de jeu
                Text("Choisissez votre mode de jeu")
                    .font(.headline)
                    .padding()
                HStack {
                    VStack {
                        Image("modeSolo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding()

                        Button("Je m'entraine") {
                            selectedMode = .solo
                            showDifficultyOptions = true
                        }
                        .buttonStyle(.borderedProminent)
                    }

                    VStack {
                        Image("modeMulti")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding()

                        Button("Seul conte des bots") {
                            selectedMode = .multiWithBots
                            showDifficultyOptions = true
                        }
                        .buttonStyle(.borderedProminent)
                    }
                }
            }
        }
        .padding()
    }
}

// Vue pour la sélection de la difficulté
struct DifficultySelectionView: View {
    var selectedMode: GameMode?

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Niveau Noob
                DifficultyCard(
                    imageName: "noobImage",
                    level: "Noob",
                    description: "Plongez dans l'univers du quiz avec des questions simples et ludiques. Idéal pour les débutants !",
                    action: {
                        // Action pour Noob
                    }
                )

                // Niveau Débutant
                DifficultyCard(
                    imageName: "beginnerImage",
                    level: "Débutant",
                    description: "Défiez-vous avec des questions légèrement plus complexes. Un pas de plus vers l'expertise !",
                    action: {
                        // Action pour Débutant
                    }
                )
                
                DifficultyCard(
                    imageName: "beginnerImage",
                    level: "Intermédiaire",
                    description: "Préparez-vous à des questions corsées. Pour ceux qui aiment les défis sérieux !",
                    action: {
                        // Action pour Débutant
                    }
                )
                
                DifficultyCard(
                    imageName: "beginnerImage",
                    level: "Vétérent",
                    description: "Questions de haut niveau pour les experts. Seuls les meilleurs réussiront !",
                    action: {
                        // Action pour Débutant
                    }
                )
                
                DifficultyCard(
                    imageName: "beginnerImage",
                    level: "Puis de savoir",
                    description: "Le sommet du quiz. Pour les maîtres incontestés du savoir et de la réflexion.",
                    action: {
                        // Action pour Débutant
                    }
                )
            }
            .padding()
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



// Énumération pour les modes de jeu
enum GameMode {
    case solo, multiWithBots
}

struct GameModeSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        GameModeSelectionView()
    }
}

