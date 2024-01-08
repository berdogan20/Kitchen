//
//  CategoriesViewNodel.swift
//  Kitchen
//
//  Created by beyza erdoğan on 8.01.2024.
//

import Foundation

class CategoriesViewModel: ObservableObject {

    private var filename = "/Users/beyzaerdogan/Desktop/Kitchen/Kitchen/DataSource/RecipesByCategoryData/categories"
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
    }

}
