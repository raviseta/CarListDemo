//
//  CarDetailViewModel.swift
//  Cars
//
//  Created by raviseta on 13/07/22.
//

import Foundation

protocol CarDetailViewModel {
    var carData: Content? {get set}
}

final class DetailViewModel: CarDetailViewModel {
    
    var carData: Content?
    
    init(carData: Content) {
        self.carData = carData
    }
    
}
