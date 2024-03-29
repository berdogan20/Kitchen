//
//  RecipeDetailDataSource.swift
//  Kitchen
//
//  Created by Yamaç Ömür on 31.12.2023.
//

import Foundation

struct RecipeDetailDataSource {

    var delegate: RecipeDetailDataSourceDelegate?
    private let baseURL = "https://api.spoonacular.com/recipes/"

    func loadRecipeDetails(recipeID: Int) {
        let session = URLSession.shared // Gets a shared URL session.

        // Creates a URL.
        guard let url =
                // swiftlint:disable:next line_length
                URL(string: "\(baseURL)\(recipeID)/information?includeNutrition=false&apiKey=1ff1bdf6a5844a5bb5270a7fabc74fa8")
        else {return}
        var request = URLRequest(url: url) // Creates a URL request.

        request.httpMethod = "GET" // Specifies the http method.
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let dataTask = session.dataTask(with: request) { data, _, error in

            guard let data else {return}
            let decoder = JSONDecoder()
            do {
                let recipeDetail = try decoder.decode(Recipe.self, from: data) // Decodes the JSON file.
                DispatchQueue.main.async {
                    delegate?.recipeDetailIsLoaded(recipeDetail: recipeDetail)
                }
            } catch {
                print(error)
            }
        }
        dataTask.resume()
    }

}
