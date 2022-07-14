//
//  CarListTableCell.swift
//  Cars
//
//  Created by raviseta on 11/07/22.
//

import UIKit
import Kingfisher

class CarListTableCell: UITableViewCell {
    
    @IBOutlet weak private var imageviewCar: UIImageView!
    @IBOutlet private var lblTitle: UILabel!
    @IBOutlet private var lblDate: UILabel!
    @IBOutlet private var lblDescription: UILabel!
    @IBOutlet weak private var viewGradiant: UIView!
    
    var viewModel: CarCellViewModel? {
        didSet {
            bindViewModel()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        DispatchQueue.main.async {
            let layer = CAGradientLayer()
            layer.frame = CGRect(x: 0, y: 0, width: self.viewGradiant.frame.width, height: self.viewGradiant.frame.height)
            layer.colors = [UIColor.black.withAlphaComponent(0.0).cgColor, UIColor.black.withAlphaComponent(0.82).cgColor, UIColor.black.withAlphaComponent(1.0).cgColor]
            layer.locations = [0, 0.2, 1]
            layer.startPoint = CGPoint(x: 0.0, y: 0.0)
            layer.endPoint = CGPoint(x: 0.0, y: 1.0)
            self.viewGradiant.layer.insertSublayer(layer, at: 0)
        }
        
    }
    
    // MARK: - BindData
    private func bindViewModel() {
        if let viewModel = viewModel {
            self.lblTitle.text = viewModel.title
            self.lblDate.text = viewModel.dateTime
            self.lblDescription.text = viewModel.ingress
            let imageURL = URL(string: viewModel.image)
            self.imageviewCar.kf.setImage(with: imageURL)
        }
    }
    
}
