//
//  CarDetailViewModel.swift
//  Cars
//
//  Created by raviseta on 13/07/22.
//

import Foundation

protocol CarDetailViewModelProtocol {
    var carData: Content? {get set}
}

final class DetailViewModel: CarDetailViewModelProtocol {
    
    var carData: Content?
    
    init(carData: Content) {
        self.carData = carData
    }
    
}
