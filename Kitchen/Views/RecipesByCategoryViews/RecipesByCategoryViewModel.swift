//
//  RecipesByCategoryView.swift
//  Kitchen
//
//  Created by beyza erdoğan on 30.12.2023.
//

import Foundation

class RecipesByCategoryViewModel: ObservableObject{

    @Published var isLoading = true
    @Published var recipesByCategory = RecipesByCategory(results: [], offset: 0, number: 0, totalResults: 0)
    private var recipesByCategoryDataSource = RecipesByCategoryDataSource()

    init(){
        recipesByCategoryDataSource.delegate = self
    }

    func loadRecipeByCategoryData(query: String, offset: Int, number: Int){
        recipesByCategoryDataSource.loadRecipesByCategoryData(query: query, offset: offset, number: number)
    }


}

extension RecipesByCategoryViewModel: RecipesByCategoryDataSourceDelegate {
    func recipesByCategoryDataLoaded(data: RecipesByCategory) {
        isLoading = false
        recipesByCategory = data
    }


}
