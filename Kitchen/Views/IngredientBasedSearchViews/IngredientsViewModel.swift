//
//  IngredientsViewModel.swift
//  Kitchen
//
//  Created by beyza erdoğan on 5.01.2024.
//

import Foundation

class IngredientsViewModel: ObservableObject {
    @Published var isLoading = true
    @Published var ingredients: Ingredients = []

    private var ingredientsDataSource = IngredientsDataSource()

    init() {
        ingredientsDataSource.delegate = self
    }

    func loadIngredients() {
        ingredientsDataSource.loadIngredientsData()
    }
}

extension IngredientsViewModel: IngredientsDataSourceDelegate {
    func ingredientsLoaded(data: Ingredients) {
        isLoading = false
        ingredients = data

        // ingredients contains the same IngredientItem multiple times
        // how to correct this
    }
}
