//
//  RecipeDetail.swift
//  Kitchen
//
//  Created by Yamaç Ömür on 31.12.2023.
//

import Foundation

// MARK: - Recipe
struct Recipe: Codable {
    let vegetarian, vegan, glutenFree, dairyFree: Bool
    let veryHealthy: Bool
    let preparationMinutes, cookingMinutes, healthScore: CGFloat
    let extendedIngredients: [ExtendedIngredient]
    let id: CGFloat
    let title: String
    let readyInMinutes, servings: CGFloat
    let image: String
    var summary: String
    var instructions: String
    let analyzedInstructions: [AnalyzedInstruction]
}

// MARK: - AnalyzedInstruction
struct AnalyzedInstruction: Codable, Hashable {
    let name: String
    let steps: [Step]
}

// MARK: - Step
struct Step: Codable, Hashable {
    let number: Int
    let step: String
}

// MARK: - ExtendedIngredient
struct ExtendedIngredient: Codable, Hashable {
    let original: String
    let image, name: String
    let amount: CGFloat
    let unit: String
}
