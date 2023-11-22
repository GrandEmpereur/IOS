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
            Spacer()

            Text("Création des questions en cours...")
                .padding()

            ProgressView()
                .scaleEffect(1.5, anchor: .center)
                .progressViewStyle(CircularProgressViewStyle(tint: .red))
                .padding()

            Spacer()
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

