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
    case invalidURL = "Invalid URL."
    case noInternet = "Internet not Available."
    case invalidResponse = "Invalid Response."
    case requestTimeOut = "Request time out."
    case noError = "No Error."
    case fileNotFound = "Unable to find file."
    case unknownError = "Unknown error."
    case XIBnotFound = "XIB not found."
}

enum ErrorDomain: String {
    case APIDomain = "API"
}

enum ResponseCode: Int {
    case success = 200
}

enum Images: String {
    case placeholderImage = "car-placeholder"
}
