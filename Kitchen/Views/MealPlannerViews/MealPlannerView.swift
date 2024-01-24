//
//  MealPlannerView.swift
//  Kitchen
//
//  Created by Yamaç Ömür on 6.01.2024.
//

import SwiftUI

struct MealPlannerView: View {

    @State private var showAlert = false
    @StateObject private var viewModel = MealPlannerViewModel()

    var body: some View {
        ZStack {
            Color.clear
                .background(
                    Image("mealPlanner")
                        .resizable()
                        .scaledToFill()
                        .blur(radius: 0.1)
                        .edgesIgnoringSafeArea(.all)
                        .opacity(0.6)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                )

            ScrollView {
                VStack {
                    Text("Plan your meals for the day!")
                        .font(.title)
                        .bold()

                    VStack {
                        calorieGoalView
                        dietaryPreferenceView
                    }
                    .padding()

                    createButtonView

                    if viewModel.userCreated && viewModel.isLoading {
                        Loading(text: "Your meal plan is coming!!")
                            .onAppear {
                                viewModel.loadMealPlan()
                            }
                        Spacer()
                    } else {
                        if let mealPlan = viewModel.mealPlan {
                            let caloriesString = String(format: "%.2f", mealPlan.nutrients.calories)
                            Spacer()
                            Text("Your meal plan for today has a total of \(caloriesString) calories.")
                                .font(.title3)
                                .foregroundStyle(.white)
                                .padding(.leading, Spacing.spacing_2)
                                .bold()
                                .multilineTextAlignment(.leading)
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 20) { // Adjust spacing between recipe views
                                    ForEach(mealPlan.meals, id: \.id) { recipe in
                                        NavigationLink(destination: RecipeDetailView(recipeID: recipe.id)) {
                                            RecipeCardView(similarRecipe: recipe)
                                                .frame(width: 200, height: 350)
                                        }
                                    }
                                }
                                .padding() // Add padding around the scroll content
                            }

                            refreshRecipeView
                            Spacer()
                        }
                    }
                }
            }
        }
    }

    private var calorieGoalView: some View {
        HStack(spacing: Spacing.spacing_1) {
            Text("Calorie Goal: ")
                .padding(.leading)
            Spacer()
            TextField("Enter calorie goal", text: $viewModel.calorieGoal)
                .padding(.leading, 5)
                .frame(width: 150, height: 31)
                .background(.white)
                .cornerRadius(8)
                .padding(.trailing)
        }
        .frame(height: 45)
        .background(.purple)
        .cornerRadius(Radius.radius_4)
    }

    private var dietaryPreferenceView: some View {
        HStack(spacing: Spacing.spacing_1) {
            Text("Dietary Preference: ")
                .padding(.leading)
            Spacer()
            DietaryPreferanceView(selection: $viewModel.selectedPreference)
                .border(Color.purple)
                .cornerRadius(10)
                .background(.purple)
                .padding(.trailing)
        }
        .frame(height: 45)
        .background(.purple)
        .cornerRadius(Radius.radius_4)
    }

    private var createButtonView: some View {
        Button {
                if !viewModel.calorieGoal.isEmpty {
                    viewModel.createMealPlan()
                } else {
                    showAlert = true
                }
        } label: {
            Text("Create")
                .foregroundStyle(.buttonText)
                .bold()
                .padding(.horizontal, Spacing.spacing_5)
                .padding(.vertical, Spacing.spacing_1)
        }
        .alert(isPresented: $showAlert) {
            // swiftlint:disable:next line_length
            Alert(title: Text("Missing Calorie Goal"), message: Text("Please enter a calorie goal before creating a meal plan."), dismissButton: .default(Text("OK")))
            }
        .frame(height: 15)
        .padding(.vertical, Spacing.spacing_2)
        .background(
            RoundedRectangle(cornerRadius: Radius.radius_4)
                .fill(Color.purple) // Set the background color directly
                .overlay(
                    RoundedRectangle(cornerRadius: Radius.radius_4)
                        .stroke(.primary, lineWidth: 1)
                        .foregroundColor(.purple)
                )
        )
    }

    private var refreshRecipeView: some View {
        Button {
            // Action to refresh and load a new random recipe
            viewModel.loadMealPlan()
        } label: {
            Text("Refresh Meal Plan")
                .foregroundColor(.black)
                .padding()
                .background(.purple)
                .cornerRadius(Radius.radius_4)
        }
        .padding()
    }
}

#Preview {
    MealPlannerView()
}
