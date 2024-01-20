//
//  MainView.swift
//  Kitchen
//
//  Created by Yamaç Ömür on 9.01.2024.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            VStack {
                CategoriesView()
            }
                .tabItem {
                    Label("Categories", systemImage: "house")
                }
            VStack {
                IngredientsView()
            }
                    .tabItem {
                        Label("Ingredient Search", systemImage: "carrot")
                    }
            VStack {
                RandomRecipeView()
            }
                .tabItem {
                    Label("Random Recipe", systemImage: "questionmark.circle")
                }
            VStack {
                MealPlannerView()
            }
                .tabItem {
                    Label("Meal Planner", systemImage: "takeoutbag.and.cup.and.straw")
                }

            VStack {
                UserProfileView()
                    .environmentObject(AuthenticationViewModel())
            }
                    .tabItem {
                        Label("My Profile", systemImage: "person.crop.circle")
                    }
            }
        }
    }

#Preview {
    MainView()
}
