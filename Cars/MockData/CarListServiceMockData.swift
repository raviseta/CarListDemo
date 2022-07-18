//
//  CarListServiceMockData.swift
//  Cars
//
//  Created by raviseta on 19/07/22.
//

import Foundation

enum Response {
    case success
    case error
}

class CarListMockService: CarListServiceProtocol {
    var response: Response = .success
    
    func getCarData(endpoint: APIURL, parameters: Encodable?) async throws -> [Content] {
        
        switch response {
        case .success:
            if !(Reachability.isConnectedToNetwork()) {
                throw APIError.noInternet
            }
            if endpoint == .none {
                throw APIError.invalidURL
            }
            do {
                let carArray = try CarServiceMockDataGenerator.mockCarList()
                return carArray
            } catch {
                throw error
            }
            
        case .error :
            throw APIError.invalidResponse
        }
    }
}
