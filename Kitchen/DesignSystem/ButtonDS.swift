//
//  ButtonDS.swift
//  Kitchen
//
//  Created by beyza erdoğan on 30.12.2023.
//

import SwiftUI

struct ButtonDS: View {

    private let buttonTitle: String
    private let action: () -> Void
    let color: Color? = .black

    init(
        buttonTitle: String,
        action: @escaping () -> Void
    ) {
        self.buttonTitle = buttonTitle
        self.action = action
    }

    var body: some View {
        Button(action: action) {
            Text(buttonTitle)
                .foregroundStyle(.buttonText)
                .bold()
                .padding(.horizontal, Spacing.spacing_5)
                .padding(.vertical, Spacing.spacing_1)
        }
        .frame(height: 15)
        .padding(.vertical, Spacing.spacing_2)
        .background(
            RoundedRectangle(cornerRadius: Radius.radius_4)
                .fill(Color.purple) // Set the background color directly
                .overlay(
                    RoundedRectangle(cornerRadius: Radius.radius_4)
                        .stroke(.primary, lineWidth: 1)
                        .foregroundColor(.purple)
                )
        )

    }
}

#Preview {
    ButtonDS(buttonTitle: "test") { }
}

