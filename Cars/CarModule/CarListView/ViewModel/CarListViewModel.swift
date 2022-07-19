//
//  CarViewModel.swift
//  Cars
//
//  Created by raviseta on 11/07/22.
//

import Foundation
import IHProgressHUD

protocol CarListViewModelProtocol {
    var numberOfRows: Int {get}
    var carListCoordinator: CarListCoordinator? {get set}
    func carItem(at index: Int) -> Content
    func didSelectCar(at index: Int)
    var reloadTableView: (() -> Void)? { get set }
    var showError: ((String) -> Void)? { get set }
    func getCarList()
}

final class CarListViewModel: CarListViewModelProtocol {
    
    // MARK: Properties
    
    var reloadTableView: (() -> Void)?
    var showError: ((String) -> Void)?
    var carListCoordinator: CarListCoordinator?
    private var carListService: CarListServiceProtocol
    
    private var arrayCarList = [Content]()
    private var totalCarItems = 0
    
    var numberOfRows: Int {
        return totalCarItems
    }
    
    // MARK: Methods
    init(carListService: CarListServiceProtocol = CarListService(netWorkManager: NetWorkManager()), carListCoordinator: CarListCoordinator) {
        self.carListService = carListService
        self.carListCoordinator = carListCoordinator
    }
    
    func carItem(at index: Int) -> Content {
        return arrayCarList[index]
    }
    
    func didSelectCar(at index: Int) {
        carListCoordinator?.gotoCarDetailScreen(carData: arrayCarList[index])
    }
    
    func getCarList() {
        Task { [weak self] in
            try await self?.getCar()
        }
    }
    
    private func getCar() async throws {
        await  IHProgressHUD.show()
        do {
            let response = try await carListService.getCarData(endpoint: .getCarList, parameters: nil)
            self.arrayCarList = response
            self.totalCarItems = self.arrayCarList.count
            self.reloadTableView?()
            await  IHProgressHUD.dismiss()
        } catch {
            self.showError?(error.localizedDescription)
            await  IHProgressHUD.dismiss()
        }
    }
    
}
