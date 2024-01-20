//
//  CategoriesView.swift
//  Kitchen
//
//  Created by beyza erdoğan on 8.01.2024.
//

import SwiftUI

struct CategoriesView: View {
    @StateObject private var viewModel = CategoriesViewModel()
    let columns: [GridItem] = [GridItem(.flexible(), spacing: 10), GridItem(.flexible(), spacing: 10)]

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                ZStack {
                    Image("categoriesBackground")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 400)
                        .clipped()

                    VStack() {
                        Text("Kitchen")
                            .font(.title)
                            .bold()
                            .foregroundColor(.white)
                            .shadow(radius: Radius.radius_3)
                            .padding(.top, Spacing.spacing_5)
                        Spacer()
                        Text("Welcome to Your Kitchen, the Ultimate Hub for Culinary Adventures! Let's turn every meal into a masterpiece together! Get ready to stir, chop, and spice up your cooking journey!")
                            .foregroundColor(.white)
                            .multilineTextAlignment(.leading)
                            .padding(.all, Spacing.spacing_1)
                            .background(Color.black.opacity(0.7)) // Solid background color
                                .cornerRadius(10)
                                .padding(10)
                                .opacity(0.9)
                            .bold()
                            .fixedSize(horizontal: false, vertical: true)
                            .frame(maxWidth: 400)
                    }
                    .padding()
                }

               Text("Categories")
                    .font(.title)
                    .bold()
                    .padding(.top, Spacing.spacing_1)
                    .shadow(radius: Radius.radius_3)
                    .padding(.leading, -150)

                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(viewModel.categories, id: \.self) { category in
                        NavigationLink(destination: RecipesByCategoryView(category: category)) {
                            RectangleCategoryView(category: category)
                                .background(.category.opacity(0.8))
                        }
                    }
                }
                .padding()
                .frame(maxWidth: 400)

            }
        }
        .ignoresSafeArea()
    }

}

struct RectangleCategoryView: View {
    let category: String

    var body: some View {
        VStack {
            Spacer()
            Image(category)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 140, height: 140)
                .clipped()
                .cornerRadius(Radius.radius_1)
                .padding(.top, Spacing.spacing_2)
            Spacer()
            Text(category)
                .foregroundColor(.white) 
                .bold()
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background(Color.gray.opacity(0.3))
        .cornerRadius(10)
    }
}

struct CategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesView()
    }
}
