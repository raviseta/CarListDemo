//
//  CarListTableCell.swift
//  Cars
//
//  Created by raviseta on 11/07/22.
//

import UIKit
import Kingfisher

class CarListTableCell: UITableViewCell {

    @IBOutlet var ivCar: UIImageView!
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var lblDate: UILabel!
    @IBOutlet var lblDescription: UILabel!
    @IBOutlet weak var viewGradiant: UIView!
    
    var viewModel: Content? {
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
        if let vm = viewModel {
            self.lblTitle.text = vm.title
            self.lblDate.text = vm.dateTime
            self.lblDescription.text = vm.ingress
            let imageURL = URL(string: vm.image)
            self.ivCar.kf.setImage(with: imageURL)
        }
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

