//
//  CarDetailViewModel.swift
//  Cars
//
//  Created by raviseta on 13/07/22.
//

import Foundation

protocol CarDetailViewModelProtocol {
    var carData: Content? {get set}
    func loadImageInWebView() -> URLRequest?
}

final class CarDetailViewModel: CarDetailViewModelProtocol {
    
    var carData: Content?
    
    init(carData: Content) {
        self.carData = carData
    }
    
    func loadImageInWebView() -> URLRequest? {
        if let imageURL = carData?.image {
            let url = URL.init(string: imageURL)
            if let url = url {
                let request = URLRequest(url: url)
                return request
            }
        }
        return nil
    }
    
}
