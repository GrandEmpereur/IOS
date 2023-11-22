//
//  DifficultySelectionView.swift
//  school project
//
//  Created by BARTOSIK Patrick on 22/11/2023.
//

import SwiftUI

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
                    level: "Vétérant",
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

struct DifficultySelectionView_Previews: PreviewProvider {
    static var previews: some View {
        DifficultySelectionView(
            selectedMode: .solo, // ou .multiWithBots selon vos besoins
            showCategorySelection: .constant(true),
            selectedDifficulty: .constant("Débutant")
        )
    }
}
