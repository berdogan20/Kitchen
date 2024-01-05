//
//  SimilarRecipeViewModel.swift
//  Kitchen
//
//  Created by beyza erdoğan on 5.01.2024.
//

import Foundation

class SimilarRecipeViewModel: ObservableObject {

    @Published var isLoading = true
    @Published var similarRecipes = SimilarRecipes()
    private var similarRecipesDataSource = SimilarRecipesDataSource()

    init(){
        similarRecipesDataSource.delegate = self
    }

    func loadSimilarRecipesData(recipeId: Int){
        similarRecipesDataSource.loadSimilarRecipesData(recipeId: recipeId)
    }
}

extension SimilarRecipeViewModel: SimilarRecipesDataSourceDelegate {
    func similarRecipesDataLoaded(data: SimilarRecipes) {
        isLoading = false
        similarRecipes = data
    }
    
}
