//
//  IngredientsDataSource.swift
//  Kitchen
//
//  Created by beyza erdoğan on 5.01.2024.
//

import Foundation

struct IngredientsDataSource {

    private let baseUrl = "https://spoonacular.com/application/frontend/downloads/ingredients.csv"
    private var ingredients: Ingredients
    var delegate: IngredientsDataSourceDelegate?

    func loadIngredientsData() {
        if let url = URL(string: urlString) {
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                    return
                }

                guard let data = data else {
                    print("No data received")
                    return
                }

                // Process the CSV data
                if let csvString = String(data: data, encoding: .utf8) {
                    // Parse the CSV content
                    let rows = csvString.components(separatedBy: "\n")
                    for row in rows {
                        let columns = row.components(separatedBy: ";")
                        if columns.count >= 2 {
                            let ingredientName = columns[0]
                            let ingredientID = columns[1]
                            let ingredient = Ingredient(name: ingredientName, id: ingredientID)
                            ingredients.append(ingredient)
                        }
                    }

                    delegate?.ingredientsLoaded(data: ingredients)
                }
            }
            task.resume()
        } else {
            print("Invalid URL")
        }
    }
}
