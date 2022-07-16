//
//  NSObject+Extension.swift
//  Cars
//
//  Created by raviseta on 11/07/22.
//

import Foundation
extension NSObject {
    @objc class var className: String {
        return String(describing: self)
    }

}
