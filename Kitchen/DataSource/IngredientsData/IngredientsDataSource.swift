//
//  IngredientsDataSource.swift
//  Kitchen
//
//  Created by beyza erdoğan on 5.01.2024.
//

import Foundation

class IngredientsDataSource {

    private let baseUrl = "https://spoonacular.com/application/frontend/downloads/ingredients.csv"
    @Published var ingredients: Ingredients = []
    var delegate: IngredientsDataSourceDelegate?

    func loadIngredientsData() {
        if let url = URL(string: baseUrl) {
            let task = URLSession.shared.dataTask(with: url) { [self] (data, _, error) in
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
                            let ingredient = IngredientItem(name: ingredientName)
                            ingredients.append(ingredient)
                        }
                    }
                    ingredients.removeFirst()
                    DispatchQueue.main.async {
                        self.delegate?.ingredientsLoaded(data: self.ingredients)
                    }
                }
            }
            task.resume()
        } else {
            print("Invalid URL")
        }
    }
}
