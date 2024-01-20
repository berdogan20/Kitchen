//
//  IngredientBasedSearchViewModel.swift
//  Kitchen
//
//  Created by beyza erdoğan on 5.01.2024.
//

import Foundation

class IngredientBasedSearchViewModel: ObservableObject {

    @Published var isLoading = true
    @Published var ingredientBasedSearch = IngredientBasedSearch()
    private var ingredientBasedSearchDataSource = IngredientBasedSearchDataSource()

    init(){
        ingredientBasedSearchDataSource.delegate = self
    }

    func loadIngredientBasedSearchData(searchIngredients: Set<IngredientItem>) {
        ingredientBasedSearchDataSource.loadIngredientBasedSearch(availableIngredients: searchIngredients)
    }
}

extension IngredientBasedSearchViewModel: IngredientBasedSearchDataSourceDelegate {
    func ingredientBasedSearchDataLoaded(data: IngredientBasedSearch) {
        isLoading = false
        ingredientBasedSearch = data
    }
}
