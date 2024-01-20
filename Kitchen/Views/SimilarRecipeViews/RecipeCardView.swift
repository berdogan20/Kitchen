//
//  RecipeCardView.swift
//  Kitchen
//
//  Created by beyza erdoğan on 5.01.2024.
//

import SwiftUI

struct RecipeCardView: View {
    let similarRecipe: SimilarRecipe

    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.spacing_1) {

            // Display recipe title
            Text(similarRecipe.title)
                .font(.headline)
                .foregroundColor(.black)

            // Additional details like servings, cook time, etc.
            HStack {
                Image(systemName: "clock")
                Text("\(similarRecipe.readyInMinutes) mins")
            }
            .foregroundColor(.gray)

            HStack {
                Image(systemName: "person.2")
                Text("\(similarRecipe.servings) servings")
            }
            .foregroundColor(.gray)
        }
        .frame(width: 150, height: 150)
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}
