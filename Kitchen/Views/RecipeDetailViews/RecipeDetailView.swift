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
            // since there is a lot of information about the recipe, I used a
            // scroll view.
            ScrollView {
                VStack(spacing: Spacing.spacing_2) {
                    if let recipeDetail = viewModel.recipeDetail, let recipeInstructions = viewModel.recipeSteps {
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
                            HStack(spacing: .zero) {
                                Text("General Description:")
                                Spacer()
                            }

                            // The description of the recipe is put below the image
                            // of the recipe.
                            LongText(text: recipeDetail.summary)
                                .font(.caption)
                            Spacer()


                            HStack(spacing: .zero) {
                                VStack(spacing: .zero) {
                                    // Unfortunately the API does not have detailed instructions for some of the recipes :(.
                                    // I did this for now.
                                    if recipeInstructions.isEmpty {
                                        HStack (spacing: Spacing.spacing_2){
                                            Text("Recipe: ")
                                            Spacer()
                                        }

                                        VStack (spacing: Spacing.spacing_2) {
                                            HStack {
                                                LongText(text: "Unfortunately, our system could not find any instructions for this recipe.")
                                                    .font(.caption)
                                                Spacer()
                                            }
                                        }
                                    }

                                    // Then, I used a ForEach loop to iterate over all the
                                    // "AnalyzedInstructions" (please check the models) and
                                    // iteratively create a "RecipeStepView" to display the
                                    // steps of the recipe.

                                    ForEach(recipeInstructions, id: \.self) { recipe in
                                        RecipeStepView(instructions: recipe)
                                    }
                                }
                            }
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
}


struct RecipeStepView: View {

    let instructions: AnalyzedSteps

    init(instructions: AnalyzedSteps) {
        self.instructions = instructions
    }

    // From the API calls, it is noticeable that the main recipe has its name as
    // an empty string, and supplementary components like sauces have their own names.
    // Thus, if the "name" property is empty, it means that we're looking at the main recipe,
    // and if the name property is something else, then it is a supplementary component.

    private var nameString: String {
        instructions.name == "" ? "Recipe:" : "\(instructions.name):"
    }
    var body: some View {
        VStack(spacing: Spacing.spacing_2) {
            HStack() {
            Text(nameString)
            Spacer()
        }
            // Goes over each of the steps and creates a LongText view to display all
            // the steps of the recipe.
            ForEach(instructions.steps, id: \.self) { step in
                HStack{
                    LongText(text: step.step)
                        .font(.caption)
                        .multilineTextAlignment(.leading)
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
            RecipeDetailView(recipeID: 69095)
        }



