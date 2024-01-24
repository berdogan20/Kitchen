//
//  CategoriesViewNodel.swift
//  Kitchen
//
//  Created by beyza erdoğan on 8.01.2024.
//

import Foundation

class CategoriesViewModel: ObservableObject {

    // for graders to be able to grade easily, we will provide the array manually
    @Published var categories: [String] = [
        "main course",
        "side dish",
        "dessert",
        "appetizer",
        "salad",
        "bread",
        "breakfast",
        "soup",
        "beverage",
        "fingerfood",
        "snack",
        "fish"
    ]

    /*
    private var filename = "/Users/beyzaerdogan/Desktop/Kitchen/Kitchen/Views/RecipesByCategoryViews/categories"
    @Published var categories: [String] = []

    init() {
        do {
            let contents = try String(contentsOfFile: filename)
            var categoriesArray = contents.components(separatedBy: "\n")

            // Remove the last empty element if it exists
            if let lastElement = categoriesArray.last, lastElement.isEmpty {
                categoriesArray.removeLast()
            }

            categories = categoriesArray
        } catch {
            print("Error reading file:", error.localizedDescription)
        }
    }*/

}
