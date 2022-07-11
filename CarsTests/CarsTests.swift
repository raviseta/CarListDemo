//
//  CarsTests.swift
//  CarsTests
//
//  Created by raviseta on 11/07/22.
//

import XCTest
@testable import Cars

class CarsTests: XCTestCase {

    var sut : CarViewModel!
    var netWorkManager : NetWorkManagerProtocol!

    override func setUp() {
        super.setUp()
        sut = CarViewModel()
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
        
    func testArticleAPIURL() throws{
        let url = eAPIURL.getCarList.getURL()
        XCTAssertEqual(url, "https://www.apphusetreach.no/application/119267/article/get_articles_list")
    }
    
    func testCarWebService_WhenGiveSuccess() throws{
        let expectation = self.expectation(description: "Success")
        
        sut.netWorkManager.request(endpoint: .getCarList, parameters: nil, responseType: Car.self) { response in
            switch response {
                
            case .success(result: let result):
                XCTAssertNotNil(result)
                expectation.fulfill()
            case .failure(error: _): break
                
            }
        }
        self.waitForExpectations(timeout: 5)
    }
    
    func testCarWebService_WhenGiveFail() throws{
        let expectation = self.expectation(description: "Fail")
        
        sut.netWorkManager.request(endpoint: .none, parameters: nil, responseType: Car.self) { response in
            switch response {
                
            case .success(result: _): break
               
            case .failure(error: let errorMessage):
                XCTAssertNotNil(errorMessage)
                expectation.fulfill()
            }
        }
        self.waitForExpectations(timeout: 5)
    }
}


