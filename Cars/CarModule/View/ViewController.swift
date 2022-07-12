//
//  ViewController.swift
//  Cars
//
//  Created by raviseta on 11/07/22.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var tblCars: UITableView!
    @IBOutlet weak private var indicator: UIActivityIndicatorView!
    
    // MARK: - Variables
    private var viewModel : CarViewModel!
    
    //MARK: - View Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }
    
    private func setupView() {
        self.tblCars.register(CarListTableCell.className)
        self.tblCars.delegate = self
        self.tblCars.dataSource = self
        self.indicator.hidesWhenStopped = true
        
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        self.getArticleDetails()
    }
        
    
    // MARK: - Get Article Data
    private func getArticleDetails() {
        
        guard Reachability.isConnectedToNetwork() else {
            return
        }
        indicator.startAnimating()
        
        viewModel = CarViewModel()
        viewModel.carListAPI {
            DispatchQueue.main.async {
                self.indicator.stopAnimating()
                self.tblCars.reloadData()
            }
        } failure: { errorMessage in
            self.showAlert(message: errorMessage)
        }
    }
}

// MARK: - Tableview Delegate & DataSource

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  viewModel.totalCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CarListTableCell.className, for: indexPath) as? CarListTableCell else {
            fatalError("CarListTableCell not found")
        }
        
        cell.viewModel = viewModel.car(at: indexPath.row)
        return cell
    }
}
