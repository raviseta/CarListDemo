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
        
        let carList: CarListViewController = .instantiate()
        let viewModel = CarListViewModel()
        viewModel.coordinator = self
        carList.viewModel = viewModel
        navigationController?.setViewControllers([carList], animated: false)
    }
    
    func gotoDetailScreen(carData: Content) {
        if let navigationController = navigationController {
            let detailCoordinator = CarDetailCoordinator(navigationController: navigationController, carData: carData)
            let detailVC = detailCoordinator.gotoCarDetailViewController()
            navigationController.pushViewController(detailVC, animated: true)
        }
       
    }
}
