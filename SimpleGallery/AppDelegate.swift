//
//  AppDelegate.swift
//  SimpleGallery
//
//  Created by Maria Angelina on 18/10/23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        UINavigationBar.appearance().tintColor = .black
        
        let rootVC = ImageGalleryViewController()
        let rootNC = UINavigationController(rootViewController: rootVC)
        window?.rootViewController = rootNC
        window?.makeKeyAndVisible()
        
        return true
    }
}

