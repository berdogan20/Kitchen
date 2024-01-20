//
//  RecipeDetailViewModel.swift
//  Kitchen
//
//  Created by Yamaç Ömür on 31.12.2023.
//

import Foundation

class RecipeDetailViewModel: ObservableObject {
    @Published var detailIsLoading = true
    private var dataSource = RecipeDetailDataSource()
    @Published var recipe: Recipe?
    @Published var recipeSteps: [AnalyzedInstruction]?
    @Published var recipeIngredients: [ExtendedIngredient]?

    init() {
        dataSource.delegate = self
    }

    func loadRecipeDetail(recipeID: Int) {
        dataSource.loadRecipeDetails(recipeID: recipeID)
    }

    // I use this function to strip the HTML tags off the recipe summary, 
    // because the API provides us with an HTML tag filled summary.
    func stripHTMLTags(recipeDetail: Recipe) {
        self.recipe?.summary = recipeDetail.summary.stripHTML
        }
    }

extension RecipeDetailViewModel: RecipeDetailDataSourceDelegate {
    func recipeDetailIsLoaded(recipeDetail: Recipe) {
        detailIsLoading = false
        self.recipe = recipeDetail
        self.recipeSteps = recipeDetail.analyzedInstructions
        self.recipeIngredients = recipeDetail.extendedIngredients
        stripHTMLTags(recipeDetail: recipeDetail)
    }
}

// the way of stripping HTML tags from a string was found 
// on: https://odenza.medium.com/how-to-stripping-html-tags-out-from-a-string-in-swift-23e3f7a2879a
extension String {
    var stripHTML: String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression)
    }
}
