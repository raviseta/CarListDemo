//
//  CarListViewTests.swift
//  CarsTests
//
//  Created by raviseta on 11/07/22.
//

import XCTest
@testable import Cars

class CarListServiceTests: XCTestCase {
    
    var sut: CarListService!
    
    override func setUp() {
        super.setUp()
        sut = CarListService(netWorkManager: NetWorkManager())
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func testCarWebService_WhenGiveSuccess() async throws {
        let expect = XCTestExpectation(description: "API Call Success")
        do {
            let response = try await sut.getCarData(endpoint: .getCarList, parameters: nil)
            XCTAssertNotNil(response)
            expect.fulfill()
            
        } catch {
            
        }
        
        wait(for: [expect], timeout: 5.0)
    }
    
    func testCarWebService_WhenGiveFail() async throws {
        let expect = XCTestExpectation(description: "API Call Fail")
        Task {[weak self] in
            do {
                _ = try await self?.sut.getCarData(endpoint: .none, parameters: nil)
                expect.fulfill()
            } catch {
                XCTAssertNotNil(error)
            }
            
            wait(for: [expect], timeout: 15.0)
        }
    }
    
}
