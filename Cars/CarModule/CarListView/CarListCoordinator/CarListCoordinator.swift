//
//  CarListCoordinator.swift
//  Cars
//
//  Created by raviseta on 13/07/22.
//

import Foundation
import UIKit

class CarListCoordinator: Coordinator {
    
    weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let carListViewModel = CarListViewModel(carListCoordinator: self)
        let carListViewController = UIStoryboard(name: StoryboardName.main.rawValue, bundle: .main).instantiateViewController(identifier: CarListViewController.className, creator: { coder -> CarListViewController? in
            CarListViewController(coder: coder, carListViewModel: carListViewModel)
        })
        navigationController?.setViewControllers([carListViewController], animated: false)
    }
    
    func gotoCarDetailScreen(carData: Content) {
        if let navigationController = navigationController {
            let carDetailCoordinator = CarDetailCoordinator(navigationController: navigationController, carData: carData)
            let carDetailViewController = carDetailCoordinator.gotoCarDetailViewController()
            navigationController.pushViewController(carDetailViewController, animated: true)
        }
        
    }
}
