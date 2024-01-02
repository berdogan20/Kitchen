//
//  RecipeDetail.swift
//  Kitchen
//
//  Created by Yamaç Ömür on 31.12.2023.
//

import Foundation


// MARK: - RecipeDetail
// The recipe API gives a very lengthy JSON list, but for the recipe screen we only need the ingredients list, the name, the image, and the summary.
struct RecipeDetail: Codable {
    let extendedIngredients: [Ingredient] // The list of ingredients needed to make the recipe.
    let title: String // The name of the recipe.
    let image: String // The image URL of the recipe.
    var summary: String // The description of the recipe.
}

// MARK: - Ingredient

struct Ingredient: Codable, Hashable {
    let original: String // Again, the API call gives a lot of information regarding the ingredients, but I believe we'd only need the ingredient name for our app.
    // This basically returns "2 tbsp of sugar" etc.
}

// MARK: - AnalyzedSteps

// When calling the recipe instructions from the API, the API can give more than one set of instructions. This is because
// the API counts the main recipe and the other components (such as sauces) as two separate recipes. Thus the API call will return an array of
// AnalyzedSteps.
struct AnalyzedSteps: Codable, Hashable {
    let name: String // If the component is not the main recipe and is, for example, a sauce, the name will be given. Else, it is an empty string.
    let steps: [Step] // All the steps needed are given as an array.
}

// MARK: - Step

struct Step: Codable, Hashable {
    let step: String // Each step has the "step" property which contains the instructions of the recipe.
}
