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
    private let viewModel: CarListViewModelProtocol!
    
    // MARK: - Initialization
    
    init?(coder: NSCoder, viewModel: CarListViewModel) {
        self.viewModel = viewModel
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
    
    // MARK: - Methods
    
    private func setupView() {
        self.configureTableView()
        self.fetchCars()
    }
    
    fileprivate func configureTableView() {
        self.tableCarList.register(CarListTableCell.className)
        self.tableCarList.delegate = self
        self.tableCarList.dataSource = self
    }
    
    fileprivate func reloadUI() {
        DispatchQueue.main.async {
            self.tableCarList.reloadData()
        }
    }
    
    private func fetchCars() {
        
        guard var viewModel = viewModel else {
            self.showAlert(message: ErrorMessage.unknownError.rawValue)
            return
        }
        
        viewModel.getCarList()
        
        viewModel.reloadTableView = { [weak self] in
            self?.reloadUI()
        }
        
        viewModel.showError = { [weak self] errorMessage in
            self?.showAlert(message: errorMessage)
        }
        
    }
}

// MARK: - Tableview Delegate & DataSource

extension CarListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  viewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CarListTableCell.className, for: indexPath) as? CarListTableCell else {
            fatalError("CarListTableCell not found")
        }
        let data = viewModel.carItem(at: indexPath.row)
        cell.carCellViewModel = CarCellViewModel(viewModel: data)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectCar(at: indexPath.row)
    }
}
