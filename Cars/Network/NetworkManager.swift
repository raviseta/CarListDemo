//
//  NetworkManager.swift
//  Cars
//
//  Created by raviseta on 11/07/22.
//

import Foundation
import UIKit

// MARK: - API ResponseHandler
typealias APIResponseHandler<T: Decodable> = ((ResponseHandler<T>) -> Void)
enum ResponseHandler<T: Decodable> {
    case success(result: T)
    case failure(error: Error)
}

// MARK: - NetworkManager

protocol NetWorkManagerProtocol {
    func request<T: Decodable>(
        endpoint: APIURL,
        parameters: Encodable?,
        responseType: T.Type) async -> ResponseHandler<T>
}

final class NetWorkManager: NetWorkManagerProtocol {
    
    private func toDictionary(modelObject: Any) -> [String: Any] {
        var dictionary = [String: Any]()
        let otherSelf = Mirror(reflecting: modelObject)
        for child in otherSelf.children {
            if let key = child.label {
                dictionary[key] = child.value
            }
        }
        return dictionary
    }
    
    func request<T: Decodable>(
        endpoint: APIURL,
        parameters: Encodable?,
        responseType: T.Type) async -> ResponseHandler<T> {
            
            let parameters = toDictionary(modelObject: parameters as Any)
            let urlParams = parameters.compactMap({ (key, value) -> String in
                return "\(key)=\(value)"
            }).joined(separator: "&")
            
            var dataTask: URLSessionDataTask?
            let defaultSession = URLSession(configuration: .default)
            
            dataTask?.cancel()
            
            if var urlComponents = URLComponents.init(string: endpoint.getURL()) {
                urlComponents.query = urlParams
                
                guard let url = urlComponents.url else {
                    return ResponseHandler.failure(error: NSError(domain: ErrorDomain.APIDomain.rawValue, code: ErrorCode.intenalServerError.rawValue, userInfo: [NSLocalizedDescriptionKey: ErrorMessage.urlNotValid.rawValue]))
                }
                
                guard Reachability.isConnectedToNetwork() else {
                    return ResponseHandler.failure(error: NSError(domain: ErrorDomain.APIDomain.rawValue, code: ErrorCode.intenalServerError.rawValue, userInfo: [NSLocalizedDescriptionKey: ErrorMessage.noInternet.rawValue]))
                }
                
                return await withCheckedContinuation { continuation in
                    dataTask = defaultSession.dataTask(with: url) { data, response, error in
                        
                        guard let data1 = data else {
                            continuation.resume(returning: .failure(error: NSError(domain: ErrorDomain.APIDomain.rawValue, code: ErrorCode.notFound.rawValue, userInfo: [NSLocalizedDescriptionKey: ErrorMessage.dataNotValid.rawValue])))
                            return
                        }
                        
                        do {
                            let response = try JSONDecoder().decode(responseType.self, from: data1)
                            continuation.resume(returning: .success(result: response))
                        } catch let err {
                            continuation.resume(returning: .failure(error: err))
                        }
                    }
                    dataTask?.resume()
                }
            }
            return ResponseHandler.failure(error: NSError(domain: ErrorDomain.APIDomain.rawValue, code: ErrorCode.intenalServerError.rawValue, userInfo: [NSLocalizedDescriptionKey: ErrorMessage.requestTimeOut.rawValue]))
        }
    
}
