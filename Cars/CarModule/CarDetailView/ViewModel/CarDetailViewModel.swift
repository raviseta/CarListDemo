//
//  CarDetailViewModel.swift
//  Cars
//
//  Created by raviseta on 13/07/22.
//

import Foundation
import IHProgressHUD

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
        IHProgressHUD.show()
        guard let imageURL = carData?.image else {
            return nil
        }
        
        let url = URL.init(string: imageURL)
        guard let url = url else {
            return nil
        }
        
        let request = URLRequest(url: url)
        return request
    }
    
}
