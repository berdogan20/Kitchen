//
//  RecipesByCategoryView.swift
//  Kitchen
//
//  Created by beyza erdoğan on 30.12.2023.
//

import SwiftUI

/*
struct RecipesByCategoryView: View {

    @StateObject private var viewModel = RecipesByCategoryViewModel()

    var body: some View {
        if viewModel.isLoading {
            Loading(text: "Recipes are Coming!!!")
                .onAppear(){
                    viewModel.loadRecipeByCategoryData(query: "salad", offset: 0, number: 10)
                }
        } else {
            NavigationView {
                List {
                    ForEach(0 ..< viewModel.recipesByCategory.results.count / 2, id: \.self) { index in
                        let startIndex = index * 2
                        let endIndex = min((index + 1) * 2, viewModel.recipesByCategory.results.count)
                        let recipesInRow = viewModel.recipesByCategory.results[startIndex..<endIndex]

                        HStack(spacing: Spacing.spacing_2) {
                            ForEach(recipesInRow, id: \.self) { recipe in
                                NavigationLink(destination: RecipeDetailView(recipeID: recipe.id)) {
                                    RecipeView(recipe: recipe)
                                        .frame(maxWidth: .infinity) // Fill available space
                                }
                            }
                        }
                        .padding(.horizontal, Spacing.spacing_2) // Add horizontal padding
                    }
                }
                .navigationTitle("Recipes")
            }
        }
    }
*/
struct RecipesByCategoryView: View {

    @StateObject private var viewModel = RecipesByCategoryViewModel()

    var body: some View {
        if viewModel.isLoading {
            Loading(text: "Recipes are Coming!!!")
                .onAppear() {
                    viewModel.loadRecipeByCategoryData(query: "salad", offset: 0, number: 10)
                }
        } else {
            NavigationView {
                List(viewModel.recipesByCategory.results, id: \.self) { recipe in
                    HStack(spacing: Spacing.spacing_2) {
                        NavigationLink(destination: RecipeDetailView(recipeID: recipe.id)) {
                            RecipeView(recipe: recipe)
                                .frame(maxWidth: .infinity) // Fill available space
                        }
                    }
                    .padding(.horizontal, Spacing.spacing_2) // Add horizontal padding
                }
                .navigationTitle("Recipes")
            }
        }
    }
}

    struct RecipeView: View {
        let recipe: Recipe // Replace Recipe with your actual Recipe model type

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

#Preview {
    RecipesByCategoryView()
}
