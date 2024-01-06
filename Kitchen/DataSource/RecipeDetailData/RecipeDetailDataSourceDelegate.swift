//
//  RecipeDetailDataSourceDelegate.swift
//  Kitchen
//
//  Created by Yamaç Ömür on 31.12.2023.
//

import Foundation

protocol RecipeDetailDataSourceDelegate: AnyObject {
    func RecipeDetailIsLoaded(recipeDetail: RecipeDetail)
    // func RecipeStepsAreLoaded(recipeSteps: [AnalyzedSteps])
}
