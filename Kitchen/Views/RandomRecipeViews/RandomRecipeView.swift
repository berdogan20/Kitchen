//
//  RandomRecipeView.swift
//  Kitchen
//
//  Created by beyza erdoğan on 5.01.2024.
//

// RandomRecipeView.swift

import SwiftUI

struct RandomRecipeView: View {
    @StateObject private var viewModel = RandomRecipeViewModel()

    var body: some View {
        if viewModel.isLoading {
            Spacer()
            Loading(text: "Recipe is Coming!!!")
                .onAppear {
                    viewModel.loadRandomRecipeData()
                }
            Spacer()
        } else {
            if let recipe = viewModel.randomRecipe.recipes.first {
                RecipeDetailView(recipeID: Int(recipe.id))
                    .id(recipe.id)
                refreshRecipeView
            }
        }

    }

    private var refreshRecipeView: some View {
        Button(action: {
            // Action to refresh and load a new random recipe
            viewModel.loadRandomRecipeData()
        }) {
            Text("Refresh")
                .foregroundColor(.white)
                .padding()
                .background(.purple)
                .cornerRadius(Radius.radius_4)
        }
        .padding()
    }
}

#Preview {
    RandomRecipeView()
}
