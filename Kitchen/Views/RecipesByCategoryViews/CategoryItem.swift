//
//  CategoryItem.swift
//  Kitchen
//
//  Created by beyza erdoğan on 17.01.2024.
//

import SwiftUI

struct CategoryItem: View {
    let category: String
    var body: some View {
        VStack(alignment: .leading) {
            Image(category)
                .renderingMode(.original)
                .resizable()
                .frame(width: 155, height: 155)
                .cornerRadius(5)
            Text(category)
                .foregroundStyle(.primary)
                .font(.subheadline)
        }
        .padding(.leading, 15)
    }
}

#Preview {
    CategoryItem(category: "salad")
}
