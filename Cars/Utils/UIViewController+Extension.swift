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
        
        let actionOK = UIAlertAction(title: "OK", style: .default, handler: { (_) -> Void in
        })
        
        dialogMessage.addAction(actionOK)
        DispatchQueue.main.async {
            self.present(dialogMessage, animated: true, completion: nil)
        }
    }
    
    static func instantiate<T>() -> T {
        let storyboard = UIStoryboard(name: StoryboardName.main.rawValue, bundle: .main)
        let viewController = storyboard.instantiateViewController(withIdentifier: "\(T.self)") as? T
        return viewController!
        
    }
}
