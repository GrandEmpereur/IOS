//
//  DifficultyCard.swift
//  school project
//
//  Created by BARTOSIK Patrick on 22/11/2023.
//

import SwiftUI

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

struct DifficultyCard_Previews: PreviewProvider {
    static var previews: some View {
        DifficultyCard(
            imageName: "logo",
            level: "Débutant",
            description: "Défiez-vous avec des questions légèrement plus complexes.",
            action: { print("Action du bouton") }
        )
    }
}
