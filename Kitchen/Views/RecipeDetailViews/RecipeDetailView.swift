//
//  RecipeDetailView.swift
//  Kitchen
//
//  Created by Yamaç Ömür on 31.12.2023.
//

import SwiftUI

struct RecipeDetailView: View {
    @StateObject private var viewModel = RecipeDetailViewModel()
    @State private var activeTab: ActiveView = .general
    enum ActiveView {
           case general, ingredients, instructions
    }
    private let recipeID: Int // to instantiate a recipe screen, someone would need to inject the recipe ID, as the recipe ID is enough to call the API

    init(recipeID: Int) {
        self.recipeID = recipeID
    }

    var body: some View {
        if viewModel.detailIsLoading {
            Loading(text: "The recipe information is coming!")
                .onAppear {
                    viewModel.loadRecipeDetail(recipeID: recipeID)
                }
        } else {
            // since there is a lot of information about the recipe, I used a
            // scroll view.

            if let recipe = viewModel.recipe {
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
                                ExtendedIngredientsView(recipe: recipe)
                            case .instructions:
                                AnalyzedInstructionsView(recipe: recipe)
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
    @Binding var activeTab: RecipeDetailView.ActiveView
    let tab: RecipeDetailView.ActiveView

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
    let recipe: Recipe?
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
    RecipeDetailView(recipeID: 406722)
}

