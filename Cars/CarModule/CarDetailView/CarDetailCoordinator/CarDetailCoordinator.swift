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
    let carData: Content
    
    init(navigationController: UINavigationController, carData: Content) {
        self.navigationController = navigationController
        self.carData = carData
    }
    
    func gotoCarDetailViewController() -> UIViewController {
        let cardetailVC: CarDetailViewController = .instantiate()
        let carDetailViewModel = CarDetailViewModel(carData: carData)
        cardetailVC.viewModel = carDetailViewModel
        return cardetailVC
    }
    
}
