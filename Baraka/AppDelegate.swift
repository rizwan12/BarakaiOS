//
//  AppDelegate.swift
//  Baraka
//
//  Created by Rizwan Saleem on 03/08/2025.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let portfolioVC = PortfolioViewController()
        let navigationController = UINavigationController(rootViewController: portfolioVC)
        
        // Customize navigation appearance
        setupNavigationAppearance()
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        return true
    }
    
    private func setupNavigationAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()    // or .configureWithDefaultBackground()
        appearance.backgroundColor = .systemBlue      // your color
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.white
        ]
        appearance.largeTitleTextAttributes = [
            .foregroundColor: UIColor.white
        ]

        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

