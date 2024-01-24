//
//  UserProfileView.swift
//  Kitchen
//
//  Created by beyza erdoğan on 28.12.2023.
//

import SwiftUI
import FirebaseAnalyticsSwift

struct UserProfileView: View {
  @EnvironmentObject var viewModel: AuthenticationViewModel
  @Environment(\.dismiss) var dismiss
  @State var presentingConfirmationDialog = false

  private func deleteAccount() {
    Task {
      if await viewModel.deleteAccount() == true {
        dismiss()
      }
    }
  }

  private func signOut() {
    viewModel.signOut()
  }

  var body: some View {
    Form {
      Section {
        VStack {
          HStack {
            Spacer()
            Image(systemName: "person.fill")
              .resizable()
              .frame(width: 100, height: 100)
              .aspectRatio(contentMode: .fit)
              .clipShape(Circle())
              .clipped()
              .padding(4)
              .overlay(Circle().stroke(Color.accentColor, lineWidth: 2))
            Spacer()
          }
          /*Button(action: {}) {
            Text("edit")
          }*/
        }
      }
      .listRowBackground(Color(UIColor.systemGroupedBackground))
      Section("Email") {
        Text(viewModel.displayName)
      }
      Section {
        Button(role: .cancel, action: signOut) {
          HStack {
            Spacer()
            Text("Sign out")
            Spacer()
          }
        }
      }
      Section {
          Button(role: .destructive) {
              presentingConfirmationDialog.toggle()
          } label: {
          HStack {
            Spacer()
            Text("Delete Account")
            Spacer()
          }
        }
      }
    }
    .navigationTitle("Profile")
    .navigationBarTitleDisplayMode(.inline)
    .confirmationDialog("Deleting your account is permanent. Do you want to delete your account?",
                        isPresented: $presentingConfirmationDialog, titleVisibility: .visible) {
      Button("Delete Account", role: .destructive, action: deleteAccount)
      Button("Cancel", role: .cancel, action: { })
    }
  }
}

struct UserProfileView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationStack {
      UserProfileView()
        .environmentObject(AuthenticationViewModel())
    }
  }
}
