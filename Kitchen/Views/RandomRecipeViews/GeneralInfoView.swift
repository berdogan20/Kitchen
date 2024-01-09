//
//  GeneralInfoView.swift
//  Kitchen
//
//  Created by beyza erdoğan on 9.01.2024.
//

import SwiftUI

struct GeneralInfoView: View {

    let recipe: RandRecipe

    var body: some View {
        RecipeInfoView(recipe: recipe)
    }
}

struct RecipeInfoView: View {
    let recipe: RandRecipe
    
    var body: some View {
        VStack (spacing: Spacing.spacing_2) {
            HStack {
                Image(systemName: "clock")
                Text("\(recipe.readyInMinutes) mins")
            }
            .foregroundColor(.gray)

            HStack {
                Image(systemName: "person.2")
                Text("\(recipe.servings ) servings")
            }
            .foregroundColor(.gray)

                RecipeInfoLabel(imageName: recipe.glutenFree ? "glutenFree" : "gluten", text: recipe.glutenFree ? "Gluten Free" : "not Gluten Free")
                RecipeInfoLabel(imageName: recipe.dairyFree ? "dairyFree" : "dairy", text: recipe.dairyFree ? "Dairy Free" : "not Dairy Free")
                RecipeInfoLabel(imageName: recipe.vegetarian ? "vegetarian" : "notVegetarian", text: recipe.vegetarian ? "Vegetarian" : "not Vegetarian")
                RecipeInfoLabel(imageName: recipe.vegan ? "vegan" : "notVegan", text: recipe.vegan ? "Vegan" : "not Vegan")
                RecipeInfoLabel(imageName: recipe.veryHealthy ? "veryHealthy" : "notHealthy", text: recipe.veryHealthy ? "Healthy" : "not Healthy")

        }
        .padding(.leading, Spacing.spacing_3)
        .padding(.top, Spacing.spacing_3)
        .frame( alignment: .center)
    }
}

struct RecipeInfoLabel: View {
    let imageName: String
    let text: String

    var body: some View {
        HStack {
            Image(imageName)
                .resizable()
                .frame(width: 20, height: 20)
                .opacity(imageName.isEmpty ? 0 : 1)
            Text(text)
        }
    }
}
