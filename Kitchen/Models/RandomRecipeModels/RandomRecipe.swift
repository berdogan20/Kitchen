//
//  RandomRecipe.swift
//  Kitchen
//
//  Created by beyza erdoğan on 5.01.2024.
//

import Foundation

// MARK: - RandomRecipe
struct RandomRecipe: Codable {
    let recipes: [RandRecipe]
}

// MARK: - Recipe
struct RandRecipe: Codable {
    let vegetarian, vegan, glutenFree, dairyFree: Bool
    let veryHealthy: Bool
    let preparationMinutes, cookingMinutes, healthScore: CGFloat
    let extendedIngredients: [ExtendedIngredient]
    let id: CGFloat
    let title: String
    let readyInMinutes, servings: CGFloat
    let image: String
    let instructions: String
    let analyzedInstructions: [AnalyzedInstruction]
}

// MARK: - AnalyzedInstruction
struct AnalyzedInstruction: Codable {
    let steps: [Instruction]
}

// MARK: - Step
struct Instruction: Codable {
    let number: Int
    let step: String
}

// MARK: - ExtendedIngredient
struct ExtendedIngredient: Codable, Hashable {
    let image, name: String
    let amount: CGFloat
    let unit: String
    let original: String
}
