//
//  CarViewModel.swift
//  Cars
//
//  Created by raviseta on 11/07/22.
//

import Foundation

protocol CarListViewModelProtocol {
    var totalCount: Int {get}
    var coordinator: CarListCoordinator? {get set}
    func getCar() async
    func car(at index: Int) -> Content
    func didSelectCar(at index: Int)
    var reloadTableView: (() -> Void)? { get set }
    var showError: ((String) -> Void)? { get set }
}

final class CarListViewModel: CarListViewModelProtocol {
    
    var reloadTableView: (() -> Void)?
    var showError: ((String) -> Void)?
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
    
    func getCar() async {
        
        let response =  await netWorkManager.request(endpoint: .getCarList, parameters: nil, responseType: Car.self)
        
        switch response {
        case .success(result: let carList):
            self.cars.append(contentsOf: carList.content)
            self.total = self.cars.count
            self.reloadTableView?()
          
        case .failure(error: let error):
            self.showError?(error.localizedDescription)
        }
        
    }
    
}
