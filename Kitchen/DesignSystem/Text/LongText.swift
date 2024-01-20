//
//  LongText.swift
//  Kitchen
//
//  Created by Yamaç Ömür on 2.01.2024.
//

import SwiftUI

// A LongText view to display long texts.
struct LongText: View {
    private let text: String

    init(text: String) {
        self.text = text
    }
    var body: some View {
       Text(text)
            .lineLimit(30)
    }
}

#Preview {
    LongText(text: "Test")
}
