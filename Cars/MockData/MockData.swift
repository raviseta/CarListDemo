//
//  MockData.swift
//  Cars
//
//  Created by raviseta on 19/07/22.
//

import Foundation

class CarServiceMockDataGenerator {
    static func mockCarList() throws -> [Content] {
        guard  let path = Bundle.main.path(forResource: "CarData", ofType: "json")
        else {
            throw APIError.fileNotFound
        }
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            let response = try decoder.decode(Car.self, from: data)
            return response.content
        } catch {
            throw APIError.fileNotFound
        }
    }
    
}
