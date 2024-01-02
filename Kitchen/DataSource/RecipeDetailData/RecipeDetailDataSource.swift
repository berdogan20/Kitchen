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
        guard let url = URL(string: "\(baseURL)\(recipeID)/information?includeNutrition=false&apiKey=1ff1bdf6a5844a5bb5270a7fabc74fa8") else {return}
        var request = URLRequest(url: url) // Creates a URL request.

        request.httpMethod = "GET" // Specifies the http method.
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let dataTask = session.dataTask(with: request) { data, response, error in

            guard let data else {return}
            let decoder = JSONDecoder()
            do {
                let recipeDetail = try decoder.decode(RecipeDetail.self, from: data) // Decodes the JSON file.
                DispatchQueue.main.async {
                    delegate?.RecipeDetailIsLoaded(recipeDetail: recipeDetail)
                }
            } catch {
                print(error)
            }
        }
        dataTask.resume()
    }

    // Works the same as the previous function, but this time receives detail instructions of the recipe.
    func loadRecipeSteps(recipeID: Int) {
        let session = URLSession.shared // Gets a shared URL session.

        // Creates a URL.
        guard let url = URL(string: "\(baseURL)\(recipeID)/analyzedInstructions?apiKey=1ff1bdf6a5844a5bb5270a7fabc74fa8") else {return}
        var request = URLRequest(url: url) // Creates a URL request.

        request.httpMethod = "GET" // Specifies the http method.
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let dataTask = session.dataTask(with: request) { data, response, error in

            guard let data else {return}
            let decoder = JSONDecoder()
            do {
                let recipeSteps = try decoder.decode([AnalyzedSteps].self, from: data) // Decodes the JSON file.
                DispatchQueue.main.async {
                    delegate?.RecipeStepsAreLoaded(recipeSteps: recipeSteps)
                }
            } catch {
                print(error)
            }
        }
        dataTask.resume()
    }

}

