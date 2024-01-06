//
//  SimilarRecipeView.swift
//  Kitchen
//
//  Created by beyza erdoğan on 5.01.2024.
//

import SwiftUI

struct SimilarRecipeView: View {

    @StateObject private var viewModel = SimilarRecipeViewModel()
    private let recipeID: Int

    init(recipeID: Int) {
        self.recipeID = recipeID
    }

    var body: some View {
        if viewModel.isLoading {
            Loading(text: "Similar recipes are Coming!!!")
                .onAppear(){
                    viewModel.loadSimilarRecipesData(recipeId: recipeID)
                }
        } else {
            NavigationView {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) { // Adjust spacing between recipe views
                        ForEach(viewModel.similarRecipes, id: \.id) { recipe in
                            NavigationLink(destination: RecipeDetailView(recipeID: recipe.id)) {
                                RecipeCardView(similarRecipe: recipe)
                                    .frame(width: 200, height: 350) // Set a fixed width for each card
                            }
                        }
                    }
                    .padding() // Add padding around the scroll content
                }
                .navigationBarTitle("Similar Recipes")

            }
        }
    }
}

#Preview {
    SimilarRecipeView(recipeID: 406722)
}
