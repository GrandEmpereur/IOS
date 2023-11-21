//
//  CategorySelectionView.swift
//  school project
//
//  Created by BARTOSIK Patrick on 21/11/2023.
//

import SwiftUI

struct CategorySelectionView: View {
    var difficulty: String

    var body: some View {
        List(QuizCategory.allCases, id: \.self) { category in
            NavigationLink(destination: QuestionView(category: category.rawValue, difficulty: difficulty)) {
                Text(category.rawValue)
            }
        }
        .navigationBarTitle("Choisissez une Catégorie", displayMode: .inline)
    }
}

struct QuestionView: View {
    var category: String
    var difficulty: String

    var body: some View {
        Text("Questions de \(category) - Difficulté: \(difficulty)")
    }
}

struct CategorySelectionView_Previews: PreviewProvider {
    static var previews: some View {
        CategorySelectionView()
    }
}
