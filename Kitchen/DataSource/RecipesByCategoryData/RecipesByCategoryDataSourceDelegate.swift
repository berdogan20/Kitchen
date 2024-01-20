//
//  RecipesByCategoryDelegate.swift
//  Kitchen
//
//  Created by beyza erdoğan on 30.12.2023.
//

import Foundation

protocol RecipesByCategoryDataSourceDelegate: AnyObject {
    func recipesByCategoryDataLoaded(data: RecipesByCategory)
}
