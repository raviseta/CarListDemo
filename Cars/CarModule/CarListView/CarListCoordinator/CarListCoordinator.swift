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
        let viewModel = CarListViewModel(coordinator: self)
        let cardetailVC = UIStoryboard(name: StoryboardName.main.rawValue, bundle: .main).instantiateViewController(identifier: CarListViewController.className, creator: { coder -> CarListViewController? in
            CarListViewController(coder: coder, viewModel: viewModel)
        })
        navigationController?.setViewControllers([cardetailVC], animated: false)
    }
    
    func gotoDetailScreen(carData: Content) {
        if let navigationController = navigationController {
            let detailCoordinator = CarDetailCoordinator(navigationController: navigationController, carData: carData)
            let detailVC = detailCoordinator.gotoCarDetailViewController()
            navigationController.pushViewController(detailVC, animated: true)
        }
        
    }
}
