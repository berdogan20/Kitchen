//
//  Loading.swift
//  Kitchen
//
//  Created by beyza erdoğan on 30.12.2023.
//

import SwiftUI

struct Loading: View {

    private let text: String

    init(text: String) {
        self.text = text
    }

    var body: some View {
        VStack(spacing: Spacing.spacing_1){
            ProgressView()
            Text(text)
        }
    }
}

#Preview {
    Loading(text: "Recipes are coming!!")
}
