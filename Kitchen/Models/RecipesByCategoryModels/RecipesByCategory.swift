//
//  RecipesByCategory.swift
//  Kitchen
//
//  Created by beyza erdoğan on 30.12.2023.
//

import Foundation

// MARK: - RecipesByCategory
struct RecipesByCategory: Codable {
    let results: [Recipe]
    let offset, number, totalResults: Int
}

// MARK: - Result
struct Recipe: Codable, Hashable {
    let id: Int
    let title: String
    let image: String
}
