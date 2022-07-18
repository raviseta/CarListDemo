//
//  CarListService.swift
//  Cars
//
//  Created by raviseta on 19/07/22.
//

import Foundation

protocol CarListServiceProtocol {
    func getCarData(endpoint: APIURL, parameters: Encodable?) async throws -> [Content]
}

class CarListService: CarListServiceProtocol {
    
    private var netWorkManager: NetWorkManagerProtocol!

    init(netWorkManager: NetWorkManagerProtocol) {
        self.netWorkManager = netWorkManager
    }
    
    func getCarData(endpoint: APIURL, parameters: Encodable?) async throws -> [Content] {
        do {
            let response =  try await netWorkManager.request(endpoint: endpoint, parameters: parameters, responseType: Car.self)
            
            switch response {
            case .success(result: let carList):
                return carList.content
          
            case .failure(error: let error):
                throw error
            }
        } catch {
            throw error
        }
    }
    
}
