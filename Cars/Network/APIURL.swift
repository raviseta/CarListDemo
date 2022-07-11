//
//  APIURL.swift
//  Cars
//
//  Created by raviseta on 11/07/22.
//

import Foundation

enum eAPIBaseURL: String {
    
    case baseURLLive = "https://www.apphusetreach.no/application/119267/"
    case baseURLTesting = ""
    
    static func getBaseURL() -> String {
        switch AppEnvironment.shared.environmentType {
        case .development:
            return eAPIBaseURL.baseURLTesting.rawValue
        case .production:
            return eAPIBaseURL.baseURLLive.rawValue
        }
    }
}

enum eAPIURL {
    case getCarList
    case none
    
    func getURL() -> String {
        let baseURL = eAPIBaseURL.getBaseURL()
        
        switch self {
        case .getCarList:
            return baseURL + "article/get_articles_list"
        case .none :
            return ""
        }
        
    }
}
