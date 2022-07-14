//
//  Constants.swift
//  Cars
//
//  Created by raviseta on 14/07/22.
//

import Foundation

let applicationName = "Cars"

enum StoryboardName: String {
    case main = "Main"
}

enum ErrorMessage: String {
    case errorDeviceJailBroken = "App can not run on jail broken devices."
    case urlNotValid = "Invalid URL."
    case noInternet = "Internet not Available."
    case dataNotValid = "Data invalid."
    case requestTimeOut = "Request time out."
}

enum ErrorDomain: String {
    case APIDomain = "API"
}

enum ErrorCode: Int {
    case intenalServerError = 500
    case notFound = 404
}
