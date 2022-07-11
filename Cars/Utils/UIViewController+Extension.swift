//
//  UIViewController+Extension.swift
//  Cars
//
//  Created by raviseta on 11/07/22.
//

import Foundation
import UIKit

extension UIViewController {
    func showAlert(title: String? = "Cars", message: String?) {
        let dialogMessage = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
        })
                
        dialogMessage.addAction(ok)
        DispatchQueue.main.async {
            self.present(dialogMessage, animated: true, completion: nil)
        }
    }
}
