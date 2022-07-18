//
//  UIDevice+JailBroken.swift
//  Cars
//
//  Created by raviseta on 14/07/22.
//

import Foundation
import UIKit

extension UIDevice {
    var isSimulator: Bool {
        return TARGET_OS_SIMULATOR != 0
    }
    
    var isJailBroken: Bool {
        get {
            if UIDevice.current.isSimulator { return false }
            return true
        }
    }
}
