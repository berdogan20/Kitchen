//
//  MealPlannerView.swift
//  Kitchen
//
//  Created by Yamaç Ömür on 6.01.2024.
//

import SwiftUI

struct MealPlannerView: View {
    
    @StateObject private var viewModel = MealPlannerViewModel()
    var body: some View {
        VStack {
            Text("Plan your meals for the day!")
                .font(.title)
                .bold()
            
            HStack(spacing: Spacing.spacing_1) {
                Text("Calorie Goal: ")
                    .padding(Spacing.spacing_2)
                TextField("Enter your calorie goal", text: $viewModel.calorieGoal)
            }
            HStack(spacing: Spacing.spacing_1) {
                Text("Dietary Preference: ")
                DietaryPreferanceView(selection: $viewModel.selectedPreference)
            }
            
            ButtonDS(buttonTitle: "Create") {
                viewModel.createMealPlan()
            }
            
            if viewModel.userCreated && viewModel.isLoading {
                Loading(text: "Your meal plan is coming!!")
                    .onAppear {
                        viewModel.loadMealPlan()
                    }
                Spacer()
            } else {
                if let mealPlan = viewModel.mealPlan {
                    let caloriesString = String(format: "%.2f", mealPlan.nutrients.calories)
                    Text("Your meal plan for today has a total of \(caloriesString) calories.")
                    Spacer()
                    NavigationView {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 20) { // Adjust spacing between recipe views
                                ForEach(mealPlan.meals, id: \.id) { recipe in
                                    NavigationLink(destination: RecipeDetailView(recipeID: recipe.id)) {
                                        RecipeCardView(similarRecipe: recipe)
                                            .frame(width: 200, height: 350) // Set a fixed width for each card
                                    }
                                }
                            }
                            .padding() // Add padding around the scroll content
                        }
                    }

                }
            }
        }
    }
}
// TODO: ADD THE CALORIES SO THAT THE USER CAN SEE HOW MUCH IT IS!!!
#Preview {
    MealPlannerView()
}
