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
                        ForEach(viewModel.ingredients, id: \.id) { ingredient in
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
                            .background(Color.blue)
                            .cornerRadius(8)
                    }
                    .disabled(selectedIngredients.isEmpty)
                }
                .navigationBarTitle("Ingredients")
            }
        }
    }
}


#Preview {
    IngredientsView()
}
