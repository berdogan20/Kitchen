//
//  RecipesByCategoryDataSource.swift
//  Kitchen
//
//  Created by beyza erdoğan on 30.12.2023.
//
import Foundation

struct RecipesByCategoryDataSource {

    private let baseURL = "https://api.spoonacular.com/recipes/complexSearch?query="
    var delegate: RecipesByCategoryDataSourceDelegate?

    func loadRecipesByCategoryData(query: String, offset: Int, number: Int) {

        // get shared URL session
        let session = URLSession.shared

        // create a URL
        // returns an optional String
        guard let url = 
                URL(string: "\(baseURL)\(query)&offset=\(offset)&number=\(number)&apiKey=cb6d93abdd024912b01fe41d5639577d")
        else {return}

        // create a URL request
        var request = URLRequest(url: url)

        // set the HTTP verb
        request.httpMethod = "GET"

        // set header for JSON
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        // create a data task
        let dataTask = session.dataTask(with: request) { data, _, _ in
            guard let data else {return}    // if the data is nil, return

            print(String(decoding: data, as: UTF8.self))   // if you receive completion handler, do this

            let decoder = JSONDecoder()
            do {
                let recipesByCaregoryData = try decoder.decode(RecipesByCategory.self, from: data)
                print(recipesByCaregoryData)

                DispatchQueue.main.async {
                    // put to main thread
                    delegate?.recipesByCategoryDataLoaded(data: recipesByCaregoryData)
                }
            }
            catch {
                print(error)
            }
        }

        // resume the data task
        dataTask.resume()
    }

}
