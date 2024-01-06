//
//  SimilarRecipesDataSource.swift
//  Kitchen
//
//  Created by beyza erdoğan on 5.01.2024.
//

import Foundation

struct IngredientBasedSearchDataSource {

    private let baseURL = "https://api.spoonacular.com/recipes/findByIngredients?ingredients="
    var delegate: IngredientBasedSearchDataSourceDelegate?

    func loadIngredientBasedSearch(availableIngredients: Set<IngredientItem>){

        // get shared URL session
        let session = URLSession.shared

        // create a URL
        // returns an optional String
        guard let url = URL(string: "\(baseURL)\(getIngredientsQuery(availableIngredients: availableIngredients))&apiKey=1ff1bdf6a5844a5bb5270a7fabc74fa8&includeNutrition=true.") else {return}

        // create a URL request
        var request = URLRequest(url: url)

        // set the HTTP verb
        request.httpMethod = "GET"

        // set header for JSON
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")


        // create a data task
        let dataTask = session.dataTask(with: request) { data, response, error in
            guard let data else {return}    // if the data is nil, return

            print(String(decoding: data, as: UTF8.self))   // if you receive completion handler, do this

            let decoder = JSONDecoder()
            do{
                let ingredientBasedSearchData = try decoder.decode(IngredientBasedSearch.self, from: data)
                print(ingredientBasedSearchData)

                DispatchQueue.main.async {
                    // put to main thread
                    delegate?.ingredientBasedSearchDataLoaded(data: ingredientBasedSearchData)
                }
            }
            catch{
                print(error)
            }
        }

        // resume the data task
        dataTask.resume()
    }

    func getIngredientsQuery(availableIngredients: Set<IngredientItem>) -> String {
        let queryIngredients = availableIngredients.map { "+\($0.name)" }
        let query = queryIngredients.joined(separator: ",")
        return query
    }

}
