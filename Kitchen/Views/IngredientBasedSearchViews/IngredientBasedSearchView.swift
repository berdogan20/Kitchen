//
//  IngredientBasedSearchView.swift
//  Kitchen
//
//  Created by beyza erdoğan on 5.01.2024.
//

import SwiftUI

struct IngredientBasedSearchView: View {

    var searchIngredients: Set<IngredientItem>
    @StateObject private var viewModel = IngredientBasedSearchViewModel()

    init(searchIngredients: Set<IngredientItem>) {
        self.searchIngredients = searchIngredients
    }

    var body: some View {
        if viewModel.isLoading {
            Loading(text: "Recipes are Coming!!!")
                .onAppear {
                    viewModel.loadIngredientBasedSearchData(searchIngredients: searchIngredients)
                }
        } else {
            Group {
                List(viewModel.ingredientBasedSearch, id: \.self) { recipe in
                    HStack(spacing: Spacing.spacing_2) {
                        NavigationLink(destination: RecipeDetailView(recipeID: recipe.id)) {
                            RecipeView(recipe: recipe)
                                .frame(maxWidth: .infinity) // Fill available space
                        }
                    }
                    .padding(.horizontal, Spacing.spacing_2) // Add horizontal padding
                }
            }
                .navigationTitle("Recipes")
                .navigationBarTitleDisplayMode(.inline)
        }
    }

    struct RecipeView: View {
        let recipe: IngredientBasedSearchElement // Replace Recipe with your actual Recipe model type

        var body: some View {
            VStack(spacing: Spacing.spacing_2) {
                AsyncImage(url: URL(string: recipe.image)) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 100, height: 100) // Fixed size
                            .cornerRadius(Radius.radius_5)
                            .clipped() // Clip the image to prevent overflow
                    } else if phase.error != nil {
                        Text("Image not found.")
                            .frame(width: 100, height: 100)
                    } else {
                        Loading(text: "Recipe is coming!!!")
                            .frame(width: 100, height: 100)
                    }
                }

                Text(recipe.title)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .padding(.horizontal, Spacing.spacing_1)
            }
        }
    }
}

#Preview {
    IngredientBasedSearchView(searchIngredients: [])
}
