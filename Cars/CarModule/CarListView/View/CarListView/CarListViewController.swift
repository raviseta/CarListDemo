//
//  ViewController.swift
//  Cars
//
//  Created by raviseta on 11/07/22.
//

import UIKit
import IHProgressHUD

class CarListViewController: BaseViewController {
    
    // MARK: - Outlets
    @IBOutlet weak private var tableCarList: UITableView!
    
    // MARK: - Variables
    var viewModel: CarListViewModelProtocol!
    
    // MARK: - View Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if UIDevice.current.isJailBroken {
            self.showAlert(message: ErrorMessage.errorDeviceJailBroken.rawValue)
            return
        }
        self.setupView()
    }
    
    private func setupView() {
        self.tableCarList.register(CarListTableCell.className)
        self.tableCarList.delegate = self
        self.tableCarList.dataSource = self
        
        self.getArticleDetails()
    }
    
    // MARK: - Get Article Data
    private func getArticleDetails() {
        
        IHProgressHUD.show()
        if let viewModel = viewModel {
            Task.init {
                let result = await viewModel.getCar()
                if result.success != nil {
                    DispatchQueue.main.async {
                        IHProgressHUD.dismiss()
                        self.tableCarList.reloadData()
                    }
                } else if let errorMessage = result.fail {
                    self.showAlert(message: errorMessage)
                }
            }
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectCar(at: indexPath.row)
    }
}
