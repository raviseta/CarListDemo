//
//  CarListCellModel.swift
//  Cars
//
//  Created by raviseta on 13/07/22.
//

import Foundation

protocol CarListCellProtocol {
    var title: String {get}
    var dateTime: String {get}
    var ingress: String {get}
    var image: String {get}
}

struct CarCellViewModel: CarListCellProtocol {
    let title: String
    let dateTime: String
    let ingress: String
    let image: String
    
    init(viewModel: Content) {
        self.title = viewModel.title
        self.dateTime = viewModel.dateTime
        self.ingress = viewModel.ingress
        self.image = viewModel.image
    }
}
