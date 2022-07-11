//
//  AppEnvironment.swift
//  Cars
//
//  Created by raviseta on 11/07/22.
//

import Foundation

enum eAppEnvironment {
    case development,
    production
}

class AppEnvironment {
    
    static let shared = AppEnvironment()
    var environmentType: eAppEnvironment = .production
    
    
}
