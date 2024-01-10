//
//  ExtendedIngredientsView.swift
//  Kitchen
//
//  Created by beyza erdoğan on 9.01.2024.
//

import SwiftUI

struct ExtendedIngredientsView: View {
    let ingredients: [ExtendedIngredient]

    init(ingredients: [ExtendedIngredient]) {
        self.ingredients = ingredients
    }
            var body: some View {
                VStack(spacing: Spacing.spacing_2) {
                    ForEach(ingredients, id: \.self) { extendedIngredient in
                            HStack {
                                Image(systemName: "circle.fill").imageScale(.small)

                                Text(extendedIngredient.original)
                                    .multilineTextAlignment(.leading)
                                Spacer()
                            }
                            .frame(alignment: .center)
                            .padding(.horizontal, Spacing.spacing_4)
                        }
                    }
                }
            }
#Preview {
    ExtendedIngredientsView(ingredients: [ExtendedIngredient(original: "10 cups of butter", image: "", name: "Hey", amount: 20, unit: "cups"), ExtendedIngredient(original: "water", image: "", name: "Bye", amount: 20, unit: "tablespoons")])
}
