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
            Spacer()
            Loading(text: "Recipe is Coming!!!")
                .onAppear() {
                    viewModel.loadRandomRecipeData()
                }
            Spacer()
        } else {
            NavigationView {
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        VStack(alignment: .center) {

                            let recipe = viewModel.randomRecipe.recipes.first

                            Text(recipe?.title ?? "")
                                .font(.headline)
                                .foregroundColor(.black)
                                .lineLimit(Int.max)
                                .multilineTextAlignment(.center) // Center the text

                            AsyncImage(url: URL(string: recipe?.image ?? "")) { phase in
                                if let image = phase.image {
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .cornerRadius(Radius.radius_5)
                                        .clipped()
                                        .frame(width: 300, height: 200)
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
                                VStack (alignment: .center){
                                    RecipeInfoView(imageName: recipe.glutenFree ? "glutenFree" : "gluten", text: recipe.glutenFree ? "Gluten Free" : "not Gluten Free")
                                    RecipeInfoView(imageName: recipe.dairyFree ? "dairyFree" : "dairy", text: recipe.dairyFree ? "Dairy Free" : "not Dairy Free")
                                    RecipeInfoView(imageName: recipe.vegetarian ? "vegetarian" : "notVegetarian", text: recipe.vegetarian ? "Vegetarian" : "not Vegetarian")
                                    RecipeInfoView(imageName: recipe.vegan ? "vegan" : "notVegan", text: recipe.vegan ? "Vegan" : "not Vegan")
                                    RecipeInfoView(imageName: recipe.veryHealthy ? "veryHealthy" : "notHealthy", text: recipe.veryHealthy ? "Healthy" : "not Healthy")
                                }

                            } else {
                                Text("No Recipe Available")
                            }

                        }

                        Spacer()
                    }
                    Spacer()
                }
                .navigationBarTitle("Random Recipe")
                .background(Color.white.edgesIgnoringSafeArea(.all))
            }
        }
    }
}

struct RecipeInfoView: View {
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

struct RandomRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        RandomRecipeView()
    }
}

