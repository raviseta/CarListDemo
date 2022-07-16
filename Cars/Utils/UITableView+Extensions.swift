//
//  UITableView+Extensions.swift
//  Cars
//
//  Created by raviseta on 11/07/22.
//

import Foundation
import UIKit

extension UITableView {
    func register(_ nibAndReuse: String) {
        register(UINib(nibName: nibAndReuse, bundle: .main), forCellReuseIdentifier: nibAndReuse)
    }
    
}
