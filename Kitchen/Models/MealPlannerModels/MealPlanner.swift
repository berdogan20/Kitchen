//
//  MealPlanner.swift
//  Kitchen
//
//  Created by Yamaç Ömür on 6.01.2024.
//

import Foundation


// MARK: - MealPlan
struct MealPlan: Codable {
    let meals: [SimilarRecipe]
    let nutrients: NutrientInfo

}

// MARK: - NutrientInfo

struct NutrientInfo: Codable {
    let calories: Float32
    let carbohydrates: Float32
    let fat: Float32
    let protein: Float32
}
