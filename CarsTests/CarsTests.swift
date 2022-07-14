//
//  CarsTests.swift
//  CarsTests
//
//  Created by raviseta on 11/07/22.
//

import XCTest
@testable import Cars

class CarsTests: XCTestCase {
    
    var sut: CarViewModel!
    var netWorkManager: NetWorkManagerProtocol!
    
    override func setUp() {
        super.setUp()
        sut = CarViewModel()
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func testgetCarURL() throws {
        let url = APIURL.getCarList.getURL()
        XCTAssertEqual(url, "https://www.apphusetreach.no/application/119267/article/get_articles_list")
    }
    
    func testCarWebService_WhenGiveSuccess() async throws {
        let expectation = self.expectation(description: "Success")
        
        let response = await sut.netWorkManager.request(endpoint: .getCarList, parameters: nil, responseType: Car.self)
        switch response {
            
        case .success(result: let result):
            XCTAssertNotNil(result)
            expectation.fulfill()
        case .failure(error: _): break
            
        }
        
        await self.waitForExpectations(timeout: 5)
    }
    
    func testCarWebService_WhenGiveFail() async throws {
        let expectation = self.expectation(description: "Fail")
        
        let response = await sut.netWorkManager.request(endpoint: .none, parameters: nil, responseType: Car.self)
        switch response {
            
        case .success(result: _): break
            
        case .failure(error: let errorMessage):
            XCTAssertNotNil(errorMessage)
            expectation.fulfill()
        }
        
        await self.waitForExpectations(timeout: 5)
    }
}
