//
//  DietaryPreferanceViewModel.swift
//  Kitchen
//
//  Created by beyza erdoğan on 8.01.2024.
//

import Foundation

class DietaryPreferanceViewModel: ObservableObject {

    // for graders to be able to grade easily, we will provide the array manually
    @Published var preferences: [String] = [
        "Gluten Free",
        "Vegetarian",
        "Ketogenic",
        "Vegan",
        "Pescetarian",
        "Paleo",
        "No Diet"
    ]

    /*private var filename = "/Users/beyzaerdogan/Desktop/Kitchen/Kitchen/Views/MealPlannerViews/preferences"
    @Published var preferences: [String] = []

    init() {
        do {
            let contents = try String(contentsOfFile: filename)
            var preferencesArray = contents.components(separatedBy: "\n")

            // Remove the last empty element if it exists
            if let lastElement = preferencesArray.last, lastElement.isEmpty {
                preferencesArray.removeLast()
            }

            preferences = preferencesArray
        } catch {
            print("Error reading file:", error.localizedDescription)
        }
    }*/
}
