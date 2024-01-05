//
//  IngredientsView.swift
//  Kitchen
//
//  Created by beyza erdoğan on 5.01.2024.
//

import SwiftUI

struct IngredientsView: View {
    
    @StateObject private var viewModel = IngredientsViewModel()

    var body: some View {
        if viewModel.isLoading {
            Loading(text: "Ingredients are Coming!!!")
                .onAppear(){
                    viewModel.loadIngredients()
                }
        } else {
            List(viewModel.ingredients, id: \.id) { ingredient in
                VStack(alignment: .leading) {
                    Text("Name: \(ingredient.name)")
                    Text("ID: \(ingredient.id)")
                }
            }
        }
    }
}

#Preview {
    IngredientsView()
}
