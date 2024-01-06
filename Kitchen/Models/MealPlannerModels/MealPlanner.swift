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
    let calories: Double
    let carbohydrates: Double
    let fat: Double
    let protein: Double
}
