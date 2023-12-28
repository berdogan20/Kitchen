//
//  UserViewModel.swift
//  Kitchen
//
//  Created by beyza erdoğan on 28.12.2023.
//

import Foundation
import SwiftUI
import FirebaseAuth

class AuthenticationViewModel: ObservableObject {
  @AppStorage("isSignedIn") var isSignedIn = false
  @Published var email = ""
  @Published var password = ""
  @Published var displayName = ""
  @Published var alert = false
  @Published var alertMessage = ""

  private func showAlertMessage(message: String) {
    alertMessage = message
    alert.toggle()
  }

  func login() {
    // check if all fields are inputted correctly
    if email.isEmpty || password.isEmpty {
      showAlertMessage(message: "Neither email nor password can be empty.")
      return
    }
    // Sign in with email and password
    Auth.auth().signIn(withEmail: email, password: password) { result, err in
      if let err = err {
        self.alertMessage = err.localizedDescription
        self.alert.toggle()
      } else {
        self.isSignedIn = true
      }
    }
  }

  func signUp() {
    // Check if all fields are inputted correctly
    if email.isEmpty || password.isEmpty {
      showAlertMessage(message: "Neither email nor password can be empty.")
      return
    }
    // Sign up with email and password
    Auth.auth().createUser(withEmail: email, password: password) { result, err in
      if let err = err {
        self.alertMessage = err.localizedDescription
        self.alert.toggle()
      } else {
        self.login()
      }
    }
  }

  func updateDisplayName() {
    print("signing up user and setting display name to: \(self.displayName)")
    // On creation of new user, set display name
    let changeRequest = Auth.auth().currentUser!.createProfileChangeRequest()
    changeRequest.displayName = self.displayName
    changeRequest.commitChanges { error in
      if let error = error {
        print("got some sort of error in display name")
        self.alertMessage = error.localizedDescription
        self.alert.toggle()
      } else {
        print("display was supposedly a success...")
      }
    }
  }

  func logout() {
    do {
      try Auth.auth().signOut()
      isSignedIn = false
      email = ""
      password = ""
    } catch {
      print("Error signing out: \(error)")
    }
  }

    func signInWithGoogle() async -> Bool {
        guard let clientID = FirebaseApp.app()?.options.clientID else {
          fatalError("No client ID found in Firebase configuration")
        }
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config

        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first,
              let rootViewController = window.rootViewController else {
          print("There is no root view controller!")
          return false
        }

          do {
            let userAuthentication = try await GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController)

            let user = userAuthentication.user
            guard let idToken = user.idToken else { throw AuthenticationError.tokenError(message: "ID token missing") }
            let accessToken = user.accessToken

            let credential = GoogleAuthProvider.credential(withIDToken: idToken.tokenString,
                                                           accessToken: accessToken.tokenString)

            let result = try await Auth.auth().signIn(with: credential)
            let firebaseUser = result.user
            print("User \(firebaseUser.uid) signed in with email \(firebaseUser.email ?? "unknown")")
            return true
          }
          catch {
            print(error.localizedDescription)
            self.errorMessage = error.localizedDescription
            return false
          }
      }
}

let user = AuthenticationViewModel()
