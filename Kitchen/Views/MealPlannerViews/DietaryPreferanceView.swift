//
//  DietaryPreferanceView.swift
//  Kitchen
//
//  Created by Yamaç Ömür on 6.01.2024.
//

import SwiftUI

struct DietaryPreferanceView: View {
    @Binding var selection: String

        let preferences = ["Gluten Free", "Vegetarian", "Ketogenic", "Vegan", "Pescetarian", "Paleo"]

        var body: some View {
            VStack {
                Picker("Select a dietary preference", selection: $selection) {
                    ForEach(preferences, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(.menu)
            }
        }
    }

// #Preview {
    // DietaryPreferanceView(selection: "Gluten Free")
// }
