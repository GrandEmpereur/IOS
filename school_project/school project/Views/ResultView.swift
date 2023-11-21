//
//  ResultView.swift
//  school project
//
//  Created by BARTOSIK Patrick on 21/11/2023.
//

import SwiftUI

struct ResultView: View {
    var correctAnswersCount: Int

    var body: some View {
        VStack {
            Text("Résultats du Quiz")
            Text("Nombre de réponses correctes : \(correctAnswersCount)")
        }
    }
}


struct ResultView_Previews: PreviewProvider {
    static var previews: some View {
        ResultView(correctAnswersCount: 2)
    }
}
