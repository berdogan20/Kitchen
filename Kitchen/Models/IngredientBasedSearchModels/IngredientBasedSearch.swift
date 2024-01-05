//
//  IngredientBasedSearch.swift
//  Kitchen
//
//  Created by beyza erdoğan on 5.01.2024.
//

import Foundation

// MARK: - IngredientBasedSearchElement
struct IngredientBasedSearchElement: Codable, Hashable, Equatable {
    let id: Int
    let title: String
    let image: String
    let usedIngredientCount, missedIngredientCount: Int
    let missedIngredients, usedIngredients, unusedIngredients: [SedIngredient]
    let likes: Int

    // Implementing hash(into:) function for Hashable conformance
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    // Implementing Equatable's == function
    static func == (lhs: IngredientBasedSearchElement, rhs: IngredientBasedSearchElement) -> Bool {
        lhs.id == rhs.id && lhs.title == rhs.title // Compare other properties if needed
    }
}

typealias IngredientBasedSearch = [IngredientBasedSearchElement]



// MARK: - SedIngredient
struct SedIngredient: Codable {
    let id: Int
    let amount: Double
    let unit, unitLong, unitShort, aisle: String
    let name, original, originalName: String
    let meta: [String]
    let image: String
    let extendedName: String?
}

