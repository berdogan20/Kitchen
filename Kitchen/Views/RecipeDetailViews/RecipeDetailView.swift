//
//  RecipeDetailView.swift
//  Kitchen
//
//  Created by Yamaç Ömür on 31.12.2023.
//

import SwiftUI

struct RecipeDetailView: View {
    @StateObject private var viewModel = RecipeDetailViewModel()
    private let recipeID: Int // to instantiate a recipe screen, someone would need to inject the recipe ID, as the recipe ID is enough to call the API
    
    init(recipeID: Int) {
        self.recipeID = recipeID
    }
    
    var body: some View {
        if viewModel.detailIsLoading || viewModel.stepsAreLoading {
            Loading(text: "The recipe information is coming!")
                .onAppear {
                    viewModel.loadRecipeDetail(recipeID: recipeID)
                    viewModel.loadSteps(recipeID: recipeID)
                }
        } else {
            VStack(spacing: Spacing.spacing_2) {
                if let recipeDetail = viewModel.recipeDetail {
                    VStack(spacing: Spacing.spacing_1) {

                        // I used a similar image manipulation as Beyza, I just
                        // enlarged the recipe image by setting different width
                        // and height.
                        AsyncImage(url: URL(string: recipeDetail.image)) { phase in
                            if let image = phase.image {
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 300, height: 200) // Fixed size
                                    .cornerRadius(Radius.radius_5)
                                    .clipped() // Clip the image to prevent overflow
                            } else if phase.error != nil {
                                Text("Image not found.")
                                    .frame(width: 100, height: 100)
                            }

                        }
                        .padding(Spacing.spacing_2)
                    }

                    // Includes the general description of the recipe. But it is
                    // too big, so I might just put it somewhere else.
                        VStack(spacing: Spacing.spacing_1) {
                            Text("General Description:")
                            Text(recipeDetail.summary)
                                .font(.caption)
                            Spacer()
                        }
                        .padding(Spacing.spacing_2)

                        .navigationTitle(recipeDetail.title)
                        .navigationBarTitleDisplayMode(.inline)
                        Spacer()
                    }
                }
            }
        }
    }
// TODO: figure out a way to get the steps of the recipe, probably through creating
// TODO: another model. Put the general description as another sheet, find similar
// TODO: recipes, and also print the ingredients list of the recipe.
        #Preview {
            RecipeDetailView(recipeID: 324694)
        }



