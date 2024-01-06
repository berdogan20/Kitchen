//
//  MealPlannerViewModel.swift
//  Kitchen
//
//  Created by Yamaç Ömür on 6.01.2024.
//

import Foundation

class MealPlannerViewModel: ObservableObject {
    @Published var calorieGoal = ""
    @Published var selectedPreference: String = "Gluten Free"
    @Published var userCreated = false
    @Published var isLoading = false
    @Published var mealPlan: MealPlan?
    private var dataSource = MealPlannerDataSource()

    init() {
        dataSource.delegate = self
    }

    func createMealPlan() {
        userCreated = true
        isLoading = true
    }

    func loadMealPlan() {
        if userCreated {
            dataSource.loadMealPlan(calories: calorieGoal, diet: selectedPreference)
        }
    }

}

extension MealPlannerViewModel: MealPlannerDataSourceDelegate {
    func mealPlanLoaded(data: MealPlan) {
        self.mealPlan = data
        isLoading = false
    }
}
