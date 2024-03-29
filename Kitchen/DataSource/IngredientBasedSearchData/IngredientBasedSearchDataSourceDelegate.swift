//
//  SimilarRecipesDataSourceDelegate.swift
//  Kitchen
//
//  Created by beyza erdoğan on 5.01.2024.
//

import Foundation

protocol IngredientBasedSearchDataSourceDelegate: AnyObject {
    func ingredientBasedSearchDataLoaded(data: IngredientBasedSearch)
}
