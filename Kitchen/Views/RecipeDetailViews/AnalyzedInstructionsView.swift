//
//  AnalyzedInstructionsView.swift
//  Kitchen
//
//  Created by beyza erdoğan on 9.01.2024.
//

import SwiftUI

struct AnalyzedInstructionsView: View {
    let recipe: Recipe
    let recipeInstructions: [AnalyzedInstruction]

    init(recipe: Recipe) {
        self.recipe = recipe
        recipeInstructions = recipe.analyzedInstructions
    }

    var body: some View {
        VStack(spacing: .zero) {
            HStack(spacing: .zero) {
                VStack(spacing: .zero) {
                    // Unfortunately the API does not have detailed instructions for some of the recipes :(.
                    // I did this for now.
                    if recipeInstructions.isEmpty {
                        HStack(spacing: Spacing.spacing_2){
                            Text("Recipe: ")
                                .font(.headline)
                                .bold()
                            Spacer()
                        }

                        VStack(spacing: Spacing.spacing_2) {
                            HStack {
                                LongText(
                                    text: "Unfortunately, our system could not find any instructions for this recipe.")
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
                }
            }
        }
        .padding(Spacing.spacing_5)
        .navigationTitle(recipe.title)
        .navigationBarTitleDisplayMode(.inline)
        Spacer()
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

    var body: some View {
            VStack(spacing: Spacing.spacing_2) {
                ForEach(instructions.steps, id: \.self) { step in
                    HStack(alignment: .top, spacing: Spacing.spacing_2) {
                        Text("\(step.number).")
                            .font(.headline)
                            .foregroundColor(.accentColor)
                            .frame(width: 30, alignment: .leading)

                        VStack(alignment: .leading, spacing: Spacing.spacing_1) {
                            Text(step.step)
                                .font(.body)
                                .multilineTextAlignment(.leading)
                                .fixedSize(horizontal: false, vertical: true)
                        }
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        .frame(width: 250) // Fixed width for the step instructions
                    }
                    .padding(.horizontal, Spacing.spacing_3)
                    .padding(.vertical, Spacing.spacing_2)
                    .background(Color.white)
                    .cornerRadius(15)
                    .shadow(radius: 5)
                    .frame(width: 300) // Fixed width for the entire step card
                }
            }
            .padding(.bottom, Spacing.spacing_2)
        }
}
