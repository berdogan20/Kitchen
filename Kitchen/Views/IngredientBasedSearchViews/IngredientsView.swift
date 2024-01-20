//
//  IngredientsView.swift
//  Kitchen
//
//  Created by beyza erdoğan on 5.01.2024.
//

import SwiftUI

struct IngredientsView: View {
    @StateObject private var viewModel = IngredientsViewModel()
    @State private var selectedIngredients: Set<IngredientItem> = []
    @State private var searchText = ""

    var body: some View {
        if viewModel.isLoading {
            Loading(text: "Ingredients are Coming!!!")
                .onAppear {
                    viewModel.loadIngredients()
                }
        } else {
            NavigationView {
                VStack {
                    // Place the List and searchable modifier in a VStack
                    VStack {
                        List {
                            ForEach(viewModel.ingredients.filter {
                                searchText.isEmpty ? true : $0.name.localizedCaseInsensitiveContains(searchText)
                            }, id: \.id) { ingredient in
                                HStack {
                                    Text("\(ingredient.name.capitalized)")
                                    Spacer()
                                    BasketToggleButton(isSelected: selectedIngredients.contains(ingredient)) {
                                        if selectedIngredients.contains(ingredient) {
                                            selectedIngredients.remove(ingredient)
                                        } else {
                                            selectedIngredients.insert(ingredient)
                                        }
                                    }
                                }
                            }
                            .listRowBackground(
                                Capsule()
                                    .fill(Color(white: 1, opacity: 0.7))
                                    .padding(.vertical, 6)
                                    .padding(.horizontal, 1)
                                    .frame(height: 55)
                            )
                            .listRowSeparator(.hidden)

                        }
                        .searchable(text: $searchText, prompt: "Search in ingredients")
                    }

                    Spacer()

                    NavigationLink(destination: IngredientBasedSearchView(searchIngredients: selectedIngredients)) {
                        Text("Search")
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.basket.opacity(2.0))
                            .cornerRadius(10)
                            .frame(height: 70)
                    }
                    .disabled(selectedIngredients.isEmpty)
                }
                .navigationBarTitle("Ingredients")
                .environment(\.defaultMinListRowHeight, 50)
                .scrollContentBackground(.hidden)
                .background {
                    Image("ingredientsBackground")
                        .resizable()
                        .scaledToFill()
                        .blur(radius: 0.1)
                        .edgesIgnoringSafeArea(.all)
                }
            }
        }
    }

    struct BasketToggleButton: View {
        let isSelected: Bool
        let action: () -> Void

        var body: some View {
            Button(action: action) {
                Image(systemName: isSelected ? "basket.fill" : "basket")
                    .foregroundColor(isSelected ? .basket : .gray)
            }
        }
    }

}

struct IngredientsView_Previews: PreviewProvider {
    static var previews: some View {
        IngredientsView()
    }
}
