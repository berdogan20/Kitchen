//
//  RecipesByCategoryView.swift
//  Kitchen
//
//  Created by beyza erdoğan on 30.12.2023.
//

import SwiftUI

struct RecipesByCategoryView: View {
    let category: String
    @State private var offset = 0
    let number = 10
    @StateObject private var viewModel = RecipesByCategoryViewModel()

    var columns: [GridItem] = [GridItem(.flexible(), spacing: Spacing.spacing_2),
                               GridItem(.flexible(), spacing: Spacing.spacing_2)]

    var body: some View {
        if viewModel.isLoading {
            Loading(text: "Recipes are Coming!!!")
                .onAppear() {
                    viewModel.loadRecipeByCategoryData(query: category, offset: offset, number: number)
                }
        } else {
            NavigationStack {
                ScrollView {
                    ZStack {
                        Image(category)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: 400)
                            .clipped()

                        VStack() {
                            Text(category)
                                .font(.title)
                                .bold()
                                .foregroundColor(.white)
                                .shadow(radius: Radius.radius_3)
                                .padding(.leading, -170)
                                .padding(.top, 330)
                        }
                        .padding()
                    }
                    LazyVGrid(columns: columns, spacing: Spacing.spacing_2) {
                        ForEach(viewModel.recipesByCategory.results, id: \.self) { recipe in
                            NavigationLink(destination: RecipeDetailView(recipeID: recipe.id)) {
                                VStack(spacing: Spacing.spacing_2) {
                                    AsyncImage(url: URL(string: recipe.image)) { phase in
                                        if let image = phase.image {
                                            image
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .frame(width: 150, height: 150) // Fixed size
                                                .cornerRadius(Radius.radius_5)
                                                .clipped() // Clip the image to prevent overflow
                                        } else if phase.error != nil {
                                            Text("Image not found.")
                                                .frame(width: 150, height: 150)
                                        } else {
                                            Loading(text: "Recipe is coming!!!")
                                                .frame(width: 150, height: 150)
                                        }
                                    }
                                    .overlay(
                                        Text(recipe.title) // Display recipe title on top of the image
                                            .foregroundColor(.white)
                                            .font(.headline)
                                            .multilineTextAlignment(.center)
                                            .padding(.horizontal, Spacing.spacing_1)
                                            .cornerRadius(Radius.radius_5)
                                            .lineLimit(4)
                                            .padding(.vertical, Spacing.spacing_0_5)
                                            .padding(.top, Spacing.spacing_4 * 2)
                                    )
                                }
                            }
                        }
                    }
                    .frame(width: 350)
                    .padding(.horizontal, Spacing.spacing_2)
                    HStack {
                        Spacer()
                        Button(action: {
                            if offset >= number {
                                offset -= number
                                viewModel.loadRecipeByCategoryData(query: category, offset: offset, number: number)
                            }
                        }) {
                            HStack {
                                Image(systemName: "backward")
                                Text("Previous")
                            }
                            .padding()
                        }

                        Button(action: {
                            offset += number
                            viewModel.loadRecipeByCategoryData(query: category, offset: offset, number: number)
                        }) {
                            HStack {
                                Text("Next")
                                Image(systemName: "forward")
                            }
                            .padding()
                        }
                        Spacer()
                    }
                    .foregroundColor(.basket)
                }
                .navigationTitle(category)

            }
            .ignoresSafeArea()
        }
    }
}
