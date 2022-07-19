//
//  AppDelegate.swift
//  Cars
//
//  Created by raviseta on 11/07/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var appCoordinator: AppCoordinator?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        if UIDevice.current.isJailBroken {
            exit(0)
        }
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        guard let window = window else {
            return false
        }
        
        appCoordinator = AppCoordinator(window: window)
        appCoordinator?.start()
        
        return true
    }
    
}
