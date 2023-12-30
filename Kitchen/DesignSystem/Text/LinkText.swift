//
//  LinkText.swift
//  Kitchen
//
//  Created by beyza erdoğan on 30.12.2023.
//

import SwiftUI

struct LinkText: View {

    let text: String

    init(text: String) {
        self.text = text
    }

    var body: some View {
        Text(text)
            .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
            .frame(width: 250, height: 30)
            .background(Color.white.opacity(0.5))
            .cornerRadius(Radius.radius_4)
            .foregroundStyle(.black)
    }

}

#Preview {
    LinkText(text: "Test Link")
}
