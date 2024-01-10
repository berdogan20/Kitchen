//
//  ExtendedIngredientsView.swift
//  Kitchen
//
//  Created by beyza erdoğan on 9.01.2024.
//

import SwiftUI

struct ExtendedIngredientsView: View {
    let recipe: Recipe
    let ingredients: [ExtendedIngredient]

    init(recipe: Recipe) {
        self.recipe = recipe
        self.ingredients = recipe.extendedIngredients
    }

    var body: some View {
        if (!ingredients.isEmpty) {
            VStack(spacing: Spacing.spacing_2) {
                // Goes over each of the steps and creates a LongText view to display all
                // the steps of the recipe.
                Text("Ingredients:")
                    .bold()
                    .font(.headline)
                    .padding(Spacing.spacing_1)
                Spacer()
                ForEach(ingredients, id: \.self) { ingredient in
                    HStack (spacing: Spacing.spacing_1){
                        Image(systemName: "circle.fill").imageScale(.small)
                        Text(ingredient.original)
                            .font(.body)
                            .multilineTextAlignment(.leading)
                        Spacer()
                    }
                }
                .padding(.bottom, Spacing.spacing_2)
            }
            .padding(.horizontal, Spacing.spacing_5)

        }
        else {
            Text("Unfortunately, our system could not find any ingredient information for this recipe.")
        }

    }
}
