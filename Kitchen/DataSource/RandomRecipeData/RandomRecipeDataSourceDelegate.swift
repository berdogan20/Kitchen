//
//  RandomRecipeDataSourceDelegate.swift
//  Kitchen
//
//  Created by beyza erdoğan on 5.01.2024.
//

import Foundation

protocol RandomRecipeDataSourceDelegate: AnyObject {
    func randomRecipeDataLoaded(data: RandomRecipe)
}
