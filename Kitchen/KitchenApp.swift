//
//  KitchenApp.swift
//  Kitchen
//
//  Created by beyza erdoğan on 19.12.2023.
//

import SwiftUI
import Firebase
import FirebaseCore
import FirebaseAuth

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    Auth.auth()
    return true
  }
}

@main
struct KitchenApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
      WindowGroup {
        NavigationStack {
          AuthenticatedView {
            Image(systemName: "fork.knife")
              .resizable()
              .aspectRatio(contentMode: .fit)
              .frame(width: 100 , height: 100)
              .clipShape(Circle())
              .clipped()
              .padding(4)
              .overlay(Circle().stroke(Color.black, lineWidth: 2))
            Text("Welcome to Kitchen!")
              .font(.title)
            Text("You need to be logged in to use this app.")
          } content: {
            // CategoriesView()
            Spacer()
          }
        }
      }
    }
}
