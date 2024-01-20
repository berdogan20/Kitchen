//
//  MealPlannerDataSource.swift
//  Kitchen
//
//  Created by Yamaç Ömür on 6.01.2024.
//

import Foundation

struct MealPlannerDataSource {

    var delegate: MealPlannerDataSourceDelegate?
    private let baseURL = "https://api.spoonacular.com/mealplanner/generate"

    func loadMealPlan(calories: String, diet: String) {
        let session = URLSession.shared // Gets a shared URL session.
        let dietString = (diet == "No Diet") ? "" : "&diet=\(diet)"
        // Creates a URL.
        guard let url = 
                URL(string: "\(baseURL)?timeFrame=day&targetCalories=\(calories)\(dietString)&apiKey=cb6d93abdd024912b01fe41d5639577d")
        else {return}
        var request = URLRequest(url: url) // Creates a URL request.

        request.httpMethod = "GET" // Specifies the http method.
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let dataTask = session.dataTask(with: request) { data, _, error in

            guard let data else {return}
            let decoder = JSONDecoder()
            do {
                let mealPlan = try decoder.decode(MealPlan.self, from: data) // Decodes the JSON file.
                DispatchQueue.main.async {
                    delegate?.mealPlanLoaded(data: mealPlan)
                }
            } catch {
                print(error)
            }
        }
        dataTask.resume()
    }

}
