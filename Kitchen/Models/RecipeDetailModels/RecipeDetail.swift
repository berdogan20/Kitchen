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
