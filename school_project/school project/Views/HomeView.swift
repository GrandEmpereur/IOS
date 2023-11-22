//
//  HomeView.swift
//  school project
//
//  Created by BARTOSIK Patrick on 20/11/2023.
//

import SwiftUI

struct HomeView: View {
    // 1. Propriété pour gérer la navigation
    @State public var navigateToGameMode = false

    var body: some View {
        NavigationView {
            VStack {
                // 2. Ajout d'une image
                Image("logo") // Assurez-vous que l'image est dans vos Assets
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)

                // 3. Ajout d'un texte
                Text("Bienvenue au Quiz de Culture Générale")
                    .font(.title)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding()

                // 4. Ajout d'un bouton
                Button(action: {
                    // Action pour naviguer vers la sélection de mode
                    navigateToGameMode = true
                }) {
                    Text("Commencer le Quiz")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }

                // 5. Navigation vers la sélection de mode de jeu
                NavigationLink(destination: GameModeSelectionView(), isActive: $navigateToGameMode) {
                    EmptyView()
                }
            }
            .padding()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
