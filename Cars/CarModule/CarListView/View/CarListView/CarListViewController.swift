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
    private var carListViewModel: CarListViewModelProtocol!
        
    // MARK: - Initialization
    
    init?(coder: NSCoder, carListViewModel: CarListViewModel) {
        self.carListViewModel = carListViewModel
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }
    
    private func setupView() {
        self.tableCarList.register(CarListTableCell.className)
        self.tableCarList.delegate = self
        self.tableCarList.dataSource = self
        
        self.getCar()
    }
    
    // MARK: - Get Cars
    
    private func getCar() {
        
        IHProgressHUD.show()
        if var viewModel = carListViewModel {
            viewModel.getCarList()
            
            viewModel.reloadTableView = { [weak self] in
                DispatchQueue.main.async {
                    IHProgressHUD.dismiss()
                    self?.tableCarList.reloadData()
                }
            }
            
            viewModel.showError = { [weak self] errorMessage in
                IHProgressHUD.dismiss()
                self?.showAlert(message: errorMessage)
            }
        }
    }
}

// MARK: - Tableview Delegate & DataSource

extension CarListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  carListViewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CarListTableCell.className, for: indexPath) as? CarListTableCell else {
            fatalError("CarListTableCell not found")
        }
        let data = carListViewModel.carItem(at: indexPath.row)
        cell.carCellViewModel = CarCellViewModel(viewModel: data)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        carListViewModel.didSelectCar(at: indexPath.row)
    }
}
