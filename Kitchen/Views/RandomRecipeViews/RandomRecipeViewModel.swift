//
//  RandomRecipeViewModel.swift
//  Kitchen
//
//  Created by beyza erdoğan on 5.01.2024.
//
import Foundation

class RandomRecipeViewModel: ObservableObject {

    @Published var isLoading = true
    @Published var randomRecipe: RandomRecipe = RandomRecipe(recipes: [])
    private var randomRecipeDataSoruce = RandomRecipeDataSource()

    init() {
        randomRecipeDataSoruce.delegate = self
    }

    func loadRandomRecipeData() {
        randomRecipeDataSoruce.loadRandomRecipeData()
    }
}

extension RandomRecipeViewModel: RandomRecipeDataSourceDelegate {
    func randomRecipeDataLoaded(data: RandomRecipe) {
        isLoading = false
        randomRecipe = data
    }
}
