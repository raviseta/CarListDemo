//
//  ViewController.swift
//  Cars
//
//  Created by raviseta on 11/07/22.
//

import UIKit

class CarListViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak private var tableCarList: UITableView!
    @IBOutlet weak private var indicator: UIActivityIndicatorView!
    
    // MARK: - Variables
    private var viewModel: CarListViewModel!
    
    // MARK: - View Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }
    
    private func setupView() {
        self.tableCarList.register(CarListTableCell.className)
        self.tableCarList.delegate = self
        self.tableCarList.dataSource = self
        self.indicator.hidesWhenStopped = true
        
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        self.getArticleDetails()
    }
    
    // MARK: - Get Article Data
    private func getArticleDetails() {
        
        indicator.startAnimating()
        
        viewModel = CarViewModel()
        viewModel.carListAPI {
            DispatchQueue.main.async {
                self.indicator.stopAnimating()
                self.tableCarList.reloadData()
            }
        } failure: { errorMessage in
            self.showAlert(message: errorMessage)
        }
    }
}

// MARK: - Tableview Delegate & DataSource

extension CarListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  viewModel.totalCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CarListTableCell.className, for: indexPath) as? CarListTableCell else {
            fatalError("CarListTableCell not found")
        }
        let data = viewModel.car(at: indexPath.row)
        cell.viewModel = CarCellViewModel(viewModel: data)
        return cell
    }
}
