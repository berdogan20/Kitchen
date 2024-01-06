//
//  IngredientDetailView.swift
//  Kitchen
//
//  Created by Yamaç Ömür on 6.01.2024.
//

import SwiftUI

struct IngredientDetailView: View {

    let ingredients: [Ingredient]

    init(ingredients: [Ingredient]) {
        self.ingredients = ingredients
    }

    var body: some View {
        VStack(spacing: Spacing.spacing_2) {
            // Goes over each of the steps and creates a LongText view to display all
            // the steps of the recipe.
            ForEach(ingredients, id: \.self) { ingredient in
                HStack (spacing: Spacing.spacing_1){
                    Text(ingredient.original)
                        .font(.caption)
                        .multilineTextAlignment(.leading)
                    Spacer()
                }
            }
        }
    }
}
