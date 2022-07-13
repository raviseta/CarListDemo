//
//  CarViewModel.swift
//  Cars
//
//  Created by raviseta on 11/07/22.
//

import Foundation

protocol CarListViewModel {
    var totalCount: Int {get}
    var coordinator: CarListCoordinator? {get set}
    func carListAPI(success: @escaping(() -> Void), failure: @escaping((String) -> Void))
    func car(at index: Int) -> Content
    func didSelectCar(at index: Int)
}

final class CarViewModel: CarListViewModel {
    
    var netWorkManager: NetWorkManagerProtocol!
    var coordinator: CarListCoordinator?
    
    private var cars = [Content]()
    private var total = 0
    
    var totalCount: Int {
        return total
    }
    
    init(netWorkManager: NetWorkManagerProtocol = NetWorkManager()) {
        self.netWorkManager = netWorkManager
    }
    
    func car(at index: Int) -> Content {
        return cars[index]
    }
    
    func didSelectCar(at index: Int) {
        coordinator?.gotoDetailScreen(carData: cars[index])
    }
    
    func carListAPI(success: @escaping(() -> Void), failure: @escaping((String) -> Void)) {
        
        netWorkManager.request(endpoint: .getCarList, parameters: nil, responseType: Car.self) { response in
            switch response {
            case .success(result: let articles):
                self.cars.append(contentsOf: articles.content)
                self.total = self.cars.count
                success()
                
            case .failure(error: let error):
                failure(error.localizedDescription)
            }
        }
        
    }
    
}
