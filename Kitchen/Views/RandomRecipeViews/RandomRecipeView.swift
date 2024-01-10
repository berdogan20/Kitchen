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
    @State private var activeTab: ActiveView = .general
    enum ActiveView {
           case general, ingredients, instructions
    }


    var body: some View {
        if viewModel.isLoading {
            Spacer()
            Loading(text: "Recipe is Coming!!!")
                .onAppear() {
                    viewModel.loadRandomRecipeData()
                }
            Spacer()
        } else {

            if let recipe = viewModel.randomRecipe.recipes.first {
                
                NavigationStack {
                    ScrollView {
                        VStack(spacing: 0) {
                            RecipeImage(recipe: recipe)
                            // Top Bar
                            HStack {
                                Spacer()
                                TabButton(label: "General", systemImage: "fork.knife.circle", activeTab: $activeTab, tab: .general)
                                Spacer()
                                TabButton(label: "Ingredients", systemImage: "swatchpalette", activeTab: $activeTab, tab: .ingredients)
                                Spacer()
                                TabButton(label: "Instructions", systemImage: "pencil.and.scribble", activeTab: $activeTab, tab: .instructions)
                                Spacer()
                            }
                            .padding()
                            
                            // Displaying corresponding view based on the active tab
                            switch activeTab {
                            case .general:
                                GeneralInfoView(recipe: recipe)
                            case .ingredients:
                                ExtendedIngredientsView(ingredients: recipe.extendedIngredients)
                            case .instructions:
                                AnalyzedInstructionsView()
                            }
                            
                            Spacer()
                        }
                    }
                    .ignoresSafeArea(.all)
                }
            }
        }

        }
}

struct TabButton: View {
    let label: String
    let systemImage: String
    @Binding var activeTab: RandomRecipeView.ActiveView
    let tab: RandomRecipeView.ActiveView

    var body: some View {
        Button(action: {
            activeTab = tab
        }) {
            VStack {
                Image(systemName: systemImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 25, height: 25)
                Text(label)
                    .font(.caption)
            }
            .foregroundColor(activeTab == tab ? .blue : .gray)
        }
    }
}

struct RecipeImage: View {
    let recipe: RandRecipe?
    var body: some View {
        AsyncImage(url: URL(string: recipe?.image ?? "")) { phase in
            if let image = phase.image {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .cornerRadius(Radius.radius_5)
                    .clipped()
                    .frame(height: 300)
                    .overlay(
                        VStack {
                            Spacer()
                            Text(recipe?.title ?? "")
                                .multilineTextAlignment(.leading)
                                .frame(alignment: .leading)
                                .foregroundColor(.white)
                                .shadow(radius: Radius.radius_2)
                                .bold()
                                .font(.title2)
                        }
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .bottom)
                    )
            } else if phase.error != nil {
                Text("Image not found.")
                    .frame(width: 100, height: 100)
            }
        }
        .ignoresSafeArea(.all)

    }
}




struct RecipeTabView: View {
    var body: some View {
        HStack  {
            Label("General", systemImage: "fork.knife.circle") // GeneralInfoView()
            Label("Ingredients", systemImage: "swatchpalette") // ExtendedIngredientsView()
            Label("Instructions", systemImage: "pencil.and.scribble")// AnalyzedInstructionsView()
        }
    }
}




#Preview {
    RandomRecipeView()
}


/*NavigationView {
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
}*/
