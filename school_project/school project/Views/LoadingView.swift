//
//  LoadingView.swift
//  school project
//
//  Created by BARTOSIK Patrick on 21/11/2023.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        VStack {
            Text("Chargement des questions...")
            // Ajoutez ici une animation ou un indicateur de progression
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.gray.opacity(0.5))
    }
}


struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
