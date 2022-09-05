//
//  YummiesApp.swift
//  Yummies
//
//  Created by Yavor Radulov on 22.07.22.
//

import SwiftUI
import FirebaseCore
import GoogleSignIn

@main
struct YummiesApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
                NavigationView {
                    ContentView()
                        .environmentObject(AuthViewModel())
                        .environmentObject(MealCardViewModel())
                }
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        
        return GIDSignIn.sharedInstance.handle(url)
    }
}
