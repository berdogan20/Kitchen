//
//  AuthenticatedView.swift
//  Kitchen
//
//  Created by beyza erdoğan on 28.12.2023.
//
import SwiftUI

extension AuthenticatedView where Unauthenticated == EmptyView {
  init(@ViewBuilder content: @escaping () -> Content) {
    self.unauthenticated = nil
    self.content = content
  }
}

struct AuthenticatedView<Content, Unauthenticated>: View where Content: View, Unauthenticated: View {
  @StateObject private var viewModel = AuthenticationViewModel()
  @State private var presentingLoginScreen = false
  @State private var presentingProfileScreen = false

  var unauthenticated: Unauthenticated?
  @ViewBuilder var content: () -> Content

  public init(unauthenticated: Unauthenticated?, @ViewBuilder content: @escaping () -> Content) {
    self.unauthenticated = unauthenticated
    self.content = content
  }

  public init(@ViewBuilder unauthenticated: @escaping () -> Unauthenticated, @ViewBuilder content: @escaping () -> Content) {
    self.unauthenticated = unauthenticated()
    self.content = content
  }


  var body: some View {
    switch viewModel.authenticationState {
    case .unauthenticated, .authenticating:
      VStack {
        if let unauthenticated {
          unauthenticated
        }
        else {
          Text("You're not logged in.")
        }
        Button("Tap here to log in") {
          viewModel.reset()
          presentingLoginScreen.toggle()
        }
        .padding()
        .foregroundColor(.green)
      }
      .sheet(isPresented: $presentingLoginScreen) {
        AuthenticationView()
          .environmentObject(viewModel)
      }
    case .authenticated:
      VStack {
        content()
        Text("You're logged in as \(viewModel.displayName).")
        Button("Tap here to view your profile") {
          presentingProfileScreen.toggle()
        }
      }
      .sheet(isPresented: $presentingProfileScreen) {
        NavigationStack {
          UserProfileView()
            .environmentObject(viewModel)
        }
      }
    }
  }
}

struct AuthenticatedView_Previews: PreviewProvider {
  static var previews: some View {
    AuthenticatedView {
      Text("You're signed in.")
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .background(.yellow)
    }
  }
}
