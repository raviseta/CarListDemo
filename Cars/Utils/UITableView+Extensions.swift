//
//  UITableView+Extensions.swift
//  Cars
//
//  Created by raviseta on 11/07/22.
//

import Foundation
import UIKit

extension UITableView {
    
    func reload(on queue: DispatchQueue = .main) {
        queue.async { self.reloadData() }
    }
    
    func dequeueCell<Cell: UITableViewCell>(for indexPath: IndexPath) -> Cell? {
        dequeueReusableCell(withIdentifier: Cell.className, for: indexPath) as? Cell
    }
    
    func register(_ nibAndReuse: String) {
        register(UINib(nibName: nibAndReuse, bundle: .main), forCellReuseIdentifier: nibAndReuse)
    }
    
    func setBoth<T>(_ dataSourceDelegate: T?) where T: UITableViewDataSource, T: UITableViewDelegate {
        dataSource = dataSourceDelegate
        delegate = dataSourceDelegate
    }
}
