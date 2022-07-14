//
//  CarListCoordinator.swift
//  Cars
//
//  Created by raviseta on 13/07/22.
//

import Foundation
import UIKit

class CarListCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        
        let carList: CarListViewController = .instantiate()
        let viewModel = CarViewModel()
        viewModel.coordinator = self
        carList.viewModel = viewModel
        navigationController.setViewControllers([carList], animated: false)
    }
    
    func gotoDetailScreen(carData: Content) {
        let detailCoordinator = CarDetailCoordinator(navigationController: navigationController)
        detailCoordinator.gotoCarDetailViewController(carData: carData)
    }
}
