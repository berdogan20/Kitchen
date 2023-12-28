//
//  ContentView.swift
//  Kitchen
//
//  Created by beyza erdoğan on 28.12.2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        LoginView()
            .environmentObject(AuthenticationViewModel())
    }
}

#Preview {
    ContentView()
}
