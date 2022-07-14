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
        let carDetailViewModel = DetailViewModel(carData: carData)
        let detailVC = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(identifier: "CarDetailViewController", creator: { coder -> CarDetailViewController? in
            CarDetailViewController(coder: coder, viewModel: carDetailViewModel)
        })
        navigationController.pushViewController(detailVC, animated: true)
    }
    
}
