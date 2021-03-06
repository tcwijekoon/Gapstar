//
//  AppDelegate.swift
//  GithubTest
//
//  Created by Thushara Wijekoon on 2021-03-06.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.window = UIWindow(frame: UIScreen.main.bounds)
         let controller = ViewController()
         window?.rootViewController = controller
         window?.makeKeyAndVisible()
        return true
    }




}

