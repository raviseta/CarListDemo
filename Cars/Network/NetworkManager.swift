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
        responseType: T.Type) async throws -> ResponseHandler<T>
}

final class NetWorkManager: NetWorkManagerProtocol {
    
    func request<T: Decodable>(
        endpoint: APIURL,
        parameters: Encodable?,
        responseType: T.Type) async throws -> ResponseHandler<T> {
            
            var dataTask: URLSessionDataTask?
            let defaultSession = URLSession(configuration: .default)
            
            dataTask?.cancel()
            
            if let urlComponents = URLComponents.init(string: endpoint.getURL()) {
                
                guard let url = urlComponents.url else {
                    return ResponseHandler.failure(error: NSError(domain: ErrorDomain.APIDomain.rawValue, code: ErrorCode.intenalServerError.rawValue, userInfo: [NSLocalizedDescriptionKey: ErrorMessage.urlNotValid.rawValue]))
                }
                
                guard Reachability.isConnectedToNetwork() else {
                    return ResponseHandler.failure(error: NSError(domain: ErrorDomain.APIDomain.rawValue, code: ErrorCode.intenalServerError.rawValue, userInfo: [NSLocalizedDescriptionKey: ErrorMessage.noInternet.rawValue]))
                }
                
                return await withCheckedContinuation { continuation in
                    dataTask = defaultSession.dataTask(with: url) { data, response, error in
                        
                        guard let data = data else {
                            continuation.resume(returning: .failure(error: NSError(domain: ErrorDomain.APIDomain.rawValue, code: ErrorCode.notFound.rawValue, userInfo: [NSLocalizedDescriptionKey: ErrorMessage.dataNotValid.rawValue])))
                            return
                        }
                        
                        do {
                            let response = try JSONDecoder().decode(responseType.self, from: data)
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
