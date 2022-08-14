//
//  RemoteConfigTestApp.swift
//  RemoteConfigTest
//
//  Created by Hidetaka Matsumoto on 2022/07/27.
//

import SwiftUI
import FirebaseCore
import FirebaseInstallations

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
      
        Installations.installations().installationID { (id, error) in
            if let error = error {
                print("Error fetching id: \(error)")
                return
            }
            guard let id = id else { return }
            CurrentUser.shared.instanceId = id
            print("Installation ID: \(id)")
        }

        return true
    }
}

@main
struct RemoteConfigTestApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
