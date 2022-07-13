//
//  AppCordinator.swift
//  Cars
//
//  Created by raviseta on 13/07/22.
//

import Foundation
import UIKit

protocol Coordinator {
    func start()
}

final class AppCoordinator: Coordinator {
    var window: UIWindow

    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let navigationController = UINavigationController()
        let carListCoordinator = CarListCoordinator(navigationController: navigationController)
        carListCoordinator.start()
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
}
