//
//  CarDetailCoordinator.swift
//  Cars
//
//  Created by raviseta on 13/07/22.
//

import Foundation
import UIKit

class CarDetailCoordinator: Coordinator {
    
    private var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
    }
    
    func gotoCarDetailViewController(carData: Content) {
        let detailVC: CarDetailViewController = .instantiate()
        let carDetailViewModel = DetailViewModel(carData: carData)
        detailVC.viewModel = carDetailViewModel
        navigationController.pushViewController(detailVC, animated: true)
    }
    
}