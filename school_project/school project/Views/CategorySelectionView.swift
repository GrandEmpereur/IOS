//
//  CategorySelectionView.swift
//  school project
//
//  Created by BARTOSIK Patrick on 23/11/2023.
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

struct CategorySelectionView_Previews: PreviewProvider {
    static var previews: some View {
        CategorySelectionView(difficulty: "Intérmédiaire")
    }
}
