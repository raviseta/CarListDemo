//
//  APIURL.swift
//  Cars
//
//  Created by raviseta on 11/07/22.
//

import Foundation

enum APIBaseURL: String {
    
    case baseURLLive = "https://www.apphusetreach.no/application/119267/"
    case baseURLTesting = ""
    
    static func getBaseURL() -> String {
        switch AppEnvironment.shared.environmentType {
        case .development:
            return APIBaseURL.baseURLTesting.rawValue
        case .production:
            return APIBaseURL.baseURLLive.rawValue
        }
    }
}

enum APIURL {
    case getCarList
    case none
    
    func getURL() -> String {
        let baseURL = APIBaseURL.getBaseURL()
        
        switch self {
        case .getCarList:
            return baseURL + "article/get_articles_list"
        case .none :
            return ""
        }
        
    }
}
