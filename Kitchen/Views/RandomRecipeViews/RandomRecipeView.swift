//
//  RandomRecipeView.swift
//  Kitchen
//
//  Created by beyza erdoğan on 5.01.2024.
//

// RandomRecipeView.swift

import SwiftUI

struct RandomRecipeView: View {
    @StateObject private var viewModel = RandomRecipeViewModel()

    var body: some View {
        if viewModel.isLoading {
            Loading(text: "Recipe is Coming!!!")
                .onAppear(){
                    viewModel.loadRandomRecipeData()
                }
        } else {
            NavigationView {
                ScrollView(.horizontal, showsIndicators: false) {
                    let recipe = viewModel.randomRecipe.recipes.first

                    Text(recipe?.title ?? "")
                        .font(.headline)
                        .foregroundColor(.black)

                    AsyncImage(url: URL(string: recipe?.image ?? "")) { phase in
                        if let image = phase.image {
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 300, height: 200) // Fixed size
                                .cornerRadius(Radius.radius_5)
                                .clipped() // Clip the image to prevent overflow
                        } else if phase.error != nil {
                            Text("Image not found.")
                                .frame(width: 100, height: 100)
                        }
                    }
                    .padding(Spacing.spacing_2)

                    HStack {
                        Image(systemName: "clock")
                        Text("\(recipe?.readyInMinutes ?? 0) mins")
                    }
                    .foregroundColor(.gray)

                    HStack {
                        Image(systemName: "person.2")
                        Text("\(recipe?.servings ?? 0) servings")
                    }
                    .foregroundColor(.gray)

                    if let recipe = recipe {
                        VStack {
                            RecipeInfoView(imageName: recipe.glutenFree ? "glutenFree" : "", text: recipe.glutenFree ? "Gluten Free" : "not Gluten Free")
                            RecipeInfoView(imageName: recipe.dairyFree ? "dairyFree" : "", text: recipe.dairyFree ? "Dairy Free" : "not Dairy Free")
                            RecipeInfoView(imageName: recipe.vegetarian ? "vegetarian" : "", text: recipe.vegetarian ? "vegetarian" : "not Begetarian")
                            RecipeInfoView(imageName: recipe.vegan ? "vegan" : "", text: recipe.vegan ? "Vegan" : "not Vegan")
                            RecipeInfoView(imageName: recipe.veryHealthy ? "veryHealthy" : "", text: recipe.veryHealthy ? "Healthy" : "not Healthy")
                        }
                    } else {
                        Text("No Recipe Available")
                    }
                    

                }
                .navigationBarTitle("Random Recipe")
            }
        }
    }
}


struct RecipeInfoView: View {
    let imageName: String
    let text: String

    var body: some View {
        HStack(spacing: 10) {
            Image(imageName)
                .resizable()
                .frame(width: 20, height: 20)
                .opacity(imageName.isEmpty ? 0 : 1) // Hide the image if the name is empty
            Text(text)
        }
    }
}


struct RandomRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        RandomRecipeView()
    }
}

