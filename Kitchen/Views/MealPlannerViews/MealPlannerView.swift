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
        ScrollView {
            VStack {
                ZStack{
                    Color.clear
                        .background(
                            Image("mealPlanner")
                                .resizable()
                                .scaledToFill()
                                .blur(radius: 0.1)
                                .edgesIgnoringSafeArea(.all)
                                .opacity(0.6)
                                .aspectRatio(contentMode: .fill)
                                .frame(height: 400)
                                .clipped()
                                .ignoresSafeArea()
                        )

                    VStack(spacing: .zero){
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
                    }
                }
                Spacer()
            }

            VStack {
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
                            VStack {
                                Text("Your Meal Plan:")
                                     .font(.title)
                                     .bold()
                                     .padding(.top, Spacing.spacing_1)
                                     .shadow(radius: Radius.radius_3)
                                     .padding(.leading, -150)
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(spacing: 20) { // Adjust spacing between recipe views
                                        ForEach(mealPlan.meals, id: \.id) { recipe in
                                            NavigationLink(destination: RecipeDetailView(recipeID: recipe.id)) {
                                                RecipeCardView(similarRecipe: recipe)
                                                    .frame(width: 200, height: 250) // Set a fixed width for each card
                                                    .background(Color.yellow.opacity(0.3))
                                                    .cornerRadius(10)
                                            }
                                        }
                                    }
                                    .ignoresSafeArea()
                                    .padding() // Add padding around the scroll content
                                }
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
