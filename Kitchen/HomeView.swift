//
//  ContentView.swift
//  Kitchen
//
//  Created by beyza erdoğan on 28.12.2023.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack {
          AuthenticatedView {
            Image(systemName: "fork.knife")
              .resizable()
              .aspectRatio(contentMode: .fit)
              .frame(width: 100 , height: 100)
              .clipShape(Circle())
              .clipped()
              .padding(4)
              .overlay(Circle().stroke(Color.black, lineWidth: 2))
            Text("Welcome to Kitchen!")
              .font(.title)
            Text("You need to be logged in to use this app.")
          } content: {
            // RecipesByCategoryView()
              //SimilarRecipeView()
             // IngredientsView()
              RandomRecipeView()
            Spacer()
          }
        }
    }
}

#Preview {
    HomeView()
}
