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
            CarListViewController(coder: coder, viewModel: carListViewModel)
        })
        navigationController?.setViewControllers([carListViewController], animated: false)
    }
    
    func gotoCarDetailScreen(carData: Content) {
        guard let navigationController = navigationController else {
            return
        }
        
        let carDetailCoordinator = CarDetailCoordinator(navigationController: navigationController, carData: carData)
        let carDetailViewController = carDetailCoordinator.gotoCarDetailViewController()
        navigationController.pushViewController(carDetailViewController, animated: true)
        
    }
}
