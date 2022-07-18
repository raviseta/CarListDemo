//
//  CarViewModel.swift
//  Cars
//
//  Created by raviseta on 11/07/22.
//

import Foundation

protocol CarListViewModelProtocol {
    var totalCount: Int {get}
    var carListCoordinator: CarListCoordinator? {get set}
    func getCar() async
    func car(at index: Int) -> Content
    func didSelectCar(at index: Int)
    var reloadTableView: (() -> Void)? { get set }
    var showError: ((String) -> Void)? { get set }
    func getCarList()
}

final class CarListViewModel: CarListViewModelProtocol {
    
    var reloadTableView: (() -> Void)?
    var showError: ((String) -> Void)?
    var netWorkManager: NetWorkManagerProtocol!
    var carListCoordinator: CarListCoordinator?
    
    private var arrayCarList = [Content]()
    private var totalCarItems = 0
    
    var totalCount: Int {
        return totalCarItems
    }
    
    init(netWorkManager: NetWorkManagerProtocol = NetWorkManager(), coordinator: CarListCoordinator) {
        self.netWorkManager = netWorkManager
        self.carListCoordinator = coordinator
    }
    
    func car(at index: Int) -> Content {
        return arrayCarList[index]
    }
    
    func didSelectCar(at index: Int) {
        carListCoordinator?.gotoDetailScreen(carData: arrayCarList[index])
    }
    
    func getCarList() {
        Task.init {
            await getCar()
        }
    }
    
    func getCar() async {
        
        let response =  await netWorkManager.request(endpoint: .getCarList, parameters: nil, responseType: Car.self)
        
        switch response {
        case .success(result: let carList):
            self.arrayCarList.append(contentsOf: carList.content)
            self.totalCarItems = self.arrayCarList.count
            self.reloadTableView?()
            
        case .failure(error: let error):
            self.showError?(error.localizedDescription)
        }
        
    }
    
}
