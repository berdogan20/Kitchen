//
//  RandomRecipeDataSource.swift
//  Kitchen
//
//  Created by beyza erdoğan on 5.01.2024.
//

import Foundation

struct RandomRecipeDataSource {

    private let baseURL = "https://api.spoonacular.com/recipes/random?apiKey=c2021be89a2f4899b11f1ab6d55c2cd8&includeNutrition=true."
    var delegate: RandomRecipeDataSourceDelegate?

    func loadRandomRecipeData(){

        // get shared URL session
        let session = URLSession.shared

        // create a URL
        // returns an optional String
        guard let url = URL(string: baseURL) else {return}

        // create a URL request
        var request = URLRequest(url: url)

        // set the HTTP verb
        request.httpMethod = "GET"

        // set header for JSON
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")


        // create a data task
        let dataTask = session.dataTask(with: request) { data, response, error in
            guard let data else {return}    // if the data is nil, return

            // print(String(decoding: data, as: UTF8.self))   // if you receive completion handler, do this

            let decoder = JSONDecoder()
            do{
                let randomRecipeData = try decoder.decode(RandomRecipe.self, from: data)
                // print(randomRecipeData)

                DispatchQueue.main.async {
                    // put to main thread
                    delegate?.randomRecipeDataLoaded(data: randomRecipeData)
                }
            }
            catch{
                print(error)
            }
        }

        // resume the data task
        dataTask.resume()
    }

}
