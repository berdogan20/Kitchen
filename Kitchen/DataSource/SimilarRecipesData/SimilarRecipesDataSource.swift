//
//  SimilarRecipesDataSource.swift
//  Kitchen
//
//  Created by beyza erdoğan on 5.01.2024.
//

import Foundation

struct SimilarRecipesDataSource {

    private let baseURL = "https://api.spoonacular.com/recipes/"
    var delegate: SimilarRecipesDataSourceDelegate?

    func loadSimilarRecipesData(recipeId: Int) {

        // get shared URL session
        let session = URLSession.shared

        // create a URL
        // returns an optional String
        guard let url =
                URL(
                    // swiftlint:disable:next line_length
                    string: "\(baseURL)\(recipeId)/similar?apiKey=cb6d93abdd024912b01fe41d5639577d&includeNutrition=true.")
        else {return}

        // create a URL request
        var request = URLRequest(url: url)

        // set the HTTP verb
        request.httpMethod = "GET"

        // set header for JSON
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        // create a data task
        let dataTask = session.dataTask(with: request) { data, _, error in
            guard let data else {return}    // if the data is nil, return

            print(String(decoding: data, as: UTF8.self))   // if you receive completion handler, do this

            let decoder = JSONDecoder()
            do {
                let similarRecipesData = try decoder.decode([SimilarRecipe].self, from: data)
                print(similarRecipesData)

                DispatchQueue.main.async {
                    // put to main thread
                    delegate?.similarRecipesDataLoaded(data: similarRecipesData)
                }
            } catch {
                print(error)
            }
        }

        // resume the data task
        dataTask.resume()
    }

}
