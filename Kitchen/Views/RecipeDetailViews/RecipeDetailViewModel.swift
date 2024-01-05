//
//  RecipeDetailViewModel.swift
//  Kitchen
//
//  Created by Yamaç Ömür on 31.12.2023.
//

import Foundation

class RecipeDetailViewModel: ObservableObject {
    @Published var detailIsLoading = true
    @Published var stepsAreLoading = true
    private var dataSource = RecipeDetailDataSource()
    @Published var recipeDetail: RecipeDetail?
    @Published var recipeSteps: [AnalyzedSteps]?

    init() {
        dataSource.delegate = self
    }

    func loadRecipeDetail(recipeID: Int) {
        dataSource.loadRecipeDetails(recipeID: recipeID)
    }

    func loadSteps(recipeID: Int) {
        dataSource.loadRecipeSteps(recipeID: recipeID)
    }

    // I use this function to strip the HTML tags off the recipe summary, because the API provides us with an HTML tag filled summary.
    func stripHTMLTags(recipeDetail: RecipeDetail) {
        self.recipeDetail?.summary = recipeDetail.summary.stripHTML
        }
    }

extension RecipeDetailViewModel: RecipeDetailDataSourceDelegate {
    func RecipeDetailIsLoaded(recipeDetail: RecipeDetail) {
        detailIsLoading = false
        self.recipeDetail = recipeDetail
        stripHTMLTags(recipeDetail: recipeDetail)
    }

    func RecipeStepsAreLoaded(recipeSteps: [AnalyzedSteps]) {
        stepsAreLoading = false
        self.recipeSteps = recipeSteps
    }
}

// the way of stripping HTML tags from a string was found on: https://odenza.medium.com/how-to-stripping-html-tags-out-from-a-string-in-swift-23e3f7a2879a
extension String {
    var stripHTML: String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression)
    }
}
