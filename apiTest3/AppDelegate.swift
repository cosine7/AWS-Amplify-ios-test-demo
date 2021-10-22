//
//  AppDelegate.swift
//  apiTest3
//
//  Created by lcx on 2021/10/21.
//

import UIKit
import Amplify
import AWSAPIPlugin

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        do {
            try Amplify.add(plugin: AWSAPIPlugin())
            try Amplify.configure()
            let queryParameters = [
                "num1": "1",
                "num2": "2"
            ]
            let request = RESTRequest(
                path: "/hello",
                queryParameters: queryParameters
            )
            Amplify.API.get(request: request) { result in
                switch result {
                case .success(let data):
                    let str = String(decoding: data, as: UTF8.self)
                    print("Success \(str)")
                case .failure(let apiError):
                    print("Failed", apiError)
                }
            }
            } catch {
                print("An error occurred setting up Amplify: \(error)")
        }
        return true
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

