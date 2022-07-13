//
//  AppEnvironment.swift
//  Cars
//
//  Created by raviseta on 11/07/22.
//

import Foundation

enum Environment {
    case development,
         production
}

class AppEnvironment {
    
    static let shared = AppEnvironment()
    var environmentType: Environment = .production
    
}
