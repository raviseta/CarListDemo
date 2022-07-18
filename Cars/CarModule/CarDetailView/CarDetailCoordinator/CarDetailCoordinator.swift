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
        let carDetailViewModel = CarDetailViewModel(carData: carData)
        let cardetailVC = UIStoryboard(name: StoryboardName.main.rawValue, bundle: .main).instantiateViewController(identifier: CarDetailViewController.className, creator: { coder -> CarDetailViewController? in
            CarDetailViewController(coder: coder, viewModel: carDetailViewModel)
        })
        return cardetailVC
    }
    
}
