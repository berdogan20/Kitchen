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
                    List {
                        ForEach(viewModel.ingredients.filter {
                            searchText.isEmpty ? true : $0.name.localizedCaseInsensitiveContains(searchText)
                        }, id: \.id) { ingredient in
                            HStack {
                                Text("\(ingredient.name)")
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
                            }
                            
                        }
                    }
                    .searchable(text: $searchText)

                    Spacer()

                    NavigationLink(destination: IngredientBasedSearchView(searchIngredients: selectedIngredients)) { // selectedIngredients: Array(selectedIngredients)
                        Text("Search")
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.purple)
                            .cornerRadius(10)
                    }
                    .disabled(selectedIngredients.isEmpty)
                }
                .navigationBarTitle("Ingredients")
                .background(Color.clear)
            }
        }
    }
    
}


#Preview {
    IngredientsView()
}
