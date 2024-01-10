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
        ZStack{

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

            VStack {
                Text("Plan your meals for the day!")
                    .font(.title)
                    .bold()

                VStack {
                    HStack(spacing: Spacing.spacing_1) {
                        Text("Calorie Goal: ")
                            .padding(.leading)
                        Spacer()
                        TextField(" Enter calorie goal", text: $viewModel.calorieGoal)
                            .frame(width: 150, height: 31)
                            .background(.white)
                            .padding(.trailing)
                    }
                    .frame(height: 45)
                    .background(.purple)
                    .cornerRadius(Radius.radius_4)

                    HStack(spacing: Spacing.spacing_1) {
                        Text("Dietary Preference: ")
                            .padding(.leading)
                        Spacer()
                        DietaryPreferanceView(selection: $viewModel.selectedPreference)
                            .border(Color(Color.purple))
                            .background(.white)
                            .padding(.trailing)
                    }
                    .frame(height: 45)
                    .background(.purple)
                    .cornerRadius(Radius.radius_4)
                }
                .padding()

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
    
}
#Preview {
    MealPlannerView()
}
