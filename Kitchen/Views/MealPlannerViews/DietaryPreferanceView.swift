//
//  DietaryPreferanceView.swift
//  Kitchen
//
//  Created by Yamaç Ömür on 6.01.2024.
//

import SwiftUI

struct DietaryPreferanceView: View {
    @Binding var selection: String
    @StateObject private var viewModel = DietaryPreferanceViewModel()

    var body: some View {
        VStack {
            Picker("Select a dietary preference", selection: $selection) {
                ForEach(viewModel.preferences, id: \.self) {
                    Text($0)
                        .foregroundStyle(.buttonText)
                }
            }
            .pickerStyle(.menu)
            .frame(width: 150, height: 31)
            .background(.white)
        }
    }
}
// #Preview {
    // DietaryPreferanceView(selection: "Gluten Free")
// }
