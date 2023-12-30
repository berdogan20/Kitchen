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
        HomeView()
      }
    }
}
