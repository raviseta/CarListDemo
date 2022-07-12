//
//  CarViewModel.swift
//  Cars
//
//  Created by raviseta on 11/07/22.
//

import Foundation

protocol CarListViewModel {
    var totalCount: Int {get}
    func carListAPI(success: @escaping(()-> ()),failure: @escaping((String) -> ()))
    func car(at index: Int) -> Content
}

final class CarViewModel : CarListViewModel  {
    
    var netWorkManager : NetWorkManagerProtocol!
    
    private var cars = [Content]()
    private var total = 0
    
    var totalCount: Int {
        return total
    }
    
    init(netWorkManager : NetWorkManagerProtocol = NetWorkManager()){
        self.netWorkManager = netWorkManager
    }
    
    func car(at index: Int) -> Content {
        return cars[index]
    }
        
    func carListAPI(success: @escaping(()-> ())
                        ,failure: @escaping((String) -> ())
    ) {
        
        netWorkManager.request(endpoint: .getCarList, parameters: nil, responseType: Car.self) { response in
            switch response {
            case .success(result: let articles):
                self.cars.append(contentsOf: articles.content)
                self.total = self.cars.count
                success()
                break
                
            case .failure(error: let error):
                failure(error.localizedDescription)
                break
            }
        }
        
    }
        
}
