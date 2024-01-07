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
                .onAppear(){
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
                                    Toggle("", isOn: Binding<Bool>(
                                        get: { selectedIngredients.contains(ingredient) },
                                        set: { isSelected in
                                            if isSelected {
                                                selectedIngredients.insert(ingredient)
                                            } else {
                                                selectedIngredients.remove(ingredient)
                                            }
                                        }
                                    ))
                                    .labelsHidden()
                                    .toggleStyle(SwitchToggleStyle(tint: Color.purple))
                                }
                            }
                        }
                        .searchable(text: $searchText, prompt: "Search in ingredients")
                    }

                    Spacer()

                    NavigationLink(destination: IngredientBasedSearchView(searchIngredients: selectedIngredients)) {
                        Text("Search")
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.purple.opacity(2.0))
                            .cornerRadius(10)
                            .frame(height: 70)
                    }
                    .disabled(selectedIngredients.isEmpty)
                }
                .navigationBarTitle("Ingredients")
            }
        }
    }
}

struct IngredientsView_Previews: PreviewProvider {
    static var previews: some View {
        IngredientsView()
    }
}
