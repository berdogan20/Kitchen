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
        if viewModel.detailIsLoading {
            Loading(text: "The recipe information is coming!")
                .onAppear {
                    viewModel.loadRecipeDetail(recipeID: recipeID)
                }
        } else {
            // since there is a lot of information about the recipe, I used a
            // scroll view.
            ScrollView {

                    if let recipeDetail = viewModel.recipeDetail, let recipeInstructions = viewModel.recipeSteps, let recipeIngredients = viewModel.recipeIngredients {
                        VStack(alignment: .leading, spacing: Spacing.spacing_2) {
                            ZStack {
                                AsyncImage(url: URL(string: recipeDetail.image)) { phase in
                                    if let image = phase.image {
                                        image
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(height: 350)
                                    } else if phase.error != nil {
                                        Text("Image not found.")
                                            .frame(width: 100, height: 100)
                                    }
                                }
                                .overlay(
                                    Text(recipeDetail.title)
                                        .foregroundColor(.white)
                                        .font(.title)
                                        .bold()
                                        .multilineTextAlignment(.leading)
                                        .lineLimit(4)
                                        .padding(.top, Spacing.spacing_5 * 7)
                                )
                            }
                        }

                        VStack (alignment: .leading) {
                            Spacer()
                            HStack {
                                Image(systemName: "clock")
                                Text("\(recipeDetail.readyInMinutes) mins")
                            }
                            .foregroundColor(.gray)
                            Spacer()
                            HStack {
                                Image(systemName: "person.2")
                                Text("\(recipeDetail.servings) servings")
                            }
                            .foregroundColor(.gray)
                        }

                        // Includes the general description of the recipe. But it is
                        // too big, so I might just put it somewhere else.
                        VStack(spacing: Spacing.spacing_1) {
                            HStack(spacing: Spacing.spacing_1) {
                                Text("General Description:")
                                    .bold()
                                    .font(.headline)
                                    .padding(Spacing.spacing_1)
                                Spacer()
                            }

                            // The description of the recipe is put below the image
                            // of the recipe.
                            LongText(text: recipeDetail.summary)
                                .font(.body)
                                .padding(Spacing.spacing_2)
                            Spacer()
                            Divider()
                            HStack(spacing: Spacing.spacing_1) {
                                Text("Ingredients:")
                                    .bold()
                                    .font(.headline)
                                    .padding(Spacing.spacing_1)
                                Spacer()
                            }

                            VStack(spacing: .zero) {
                                if (recipeIngredients.isEmpty) {
                                    Text("Unfortunately, our system could not find any ingredient information for this recipe.")
                                } else {
                                        IngredientDetailView(ingredients: Array(Set(recipeIngredients)))
                                }

                                Divider()
                                HStack(spacing: .zero) {
                                    VStack(spacing: .zero) {
                                        // Unfortunately the API does not have detailed instructions for some of the recipes :(.
                                        // I did this for now.
                                        if recipeInstructions.isEmpty {
                                            HStack (spacing: Spacing.spacing_2){
                                                Text("Recipe: ")
                                                    .font(.headline)
                                                    .bold()
                                                Spacer()
                                            }

                                            VStack (spacing: Spacing.spacing_2) {
                                                HStack {
                                                    LongText(text: "Unfortunately, our system could not find any instructions for this recipe.")
                                                        .font(.body)
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

                                        SimilarRecipeView(recipeID: recipeID)
                                    }
                                }
                            }
                            .padding(Spacing.spacing_2)
                            .navigationTitle(recipeDetail.title)
                            .navigationBarTitleDisplayMode(.inline)
                            Spacer()
                        }
                        .padding(.leading, Spacing.spacing_5 * 2)
                        .padding(.trailing, Spacing.spacing_5 * 2)

                }
            }
            .ignoresSafeArea()

        }
    }

}


    struct RecipeStepView: View {

        let instructions: AnalyzedInstruction

        init(instructions: AnalyzedInstruction) {
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
                        .bold()
                        .font(.headline)
                        .padding(Spacing.spacing_1)
                    Spacer()
                }
                // Goes over each of the steps and creates a LongText view to display all
                // the steps of the recipe.
                ForEach(instructions.steps, id: \.self) { step in
                    HStack{
                        LongText(text: step.step)
                            .font(.body)
                            .multilineTextAlignment(.leading)
                        Spacer()
                    }
                }
            }
        }
    }
#Preview {
    RecipeDetailView(recipeID: 406722)
}

