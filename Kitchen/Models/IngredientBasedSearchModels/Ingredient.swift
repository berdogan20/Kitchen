//
//  Ingredient.swift
//  Kitchen
//
//  Created by beyza erdoğan on 5.01.2024.
//

import Foundation

struct IngredientItem: Identifiable, Equatable, Hashable {
    let name: String
    var id: String // Using name as the identifier

    init(name: String) {
        self.name = name
        self.id = name // Assigning the name as the id
    }

    static func == (lhs: IngredientItem, rhs: IngredientItem) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

typealias Ingredients = [IngredientItem]
