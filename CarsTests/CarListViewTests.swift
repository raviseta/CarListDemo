//
//  CarListViewTests.swift
//  CarsTests
//
//  Created by raviseta on 11/07/22.
//

import XCTest
@testable import Cars

class CarListViewTests: XCTestCase {
    
    var sut: CarListViewModel!
    var netWorkManager: NetWorkManagerProtocol!
    let navigationController = UINavigationController()
    
    override func setUp() {
        super.setUp()
        let carListCoordinator = CarListCoordinator(navigationController: navigationController)
        sut = CarListViewModel(carListCoordinator: carListCoordinator)
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
        do {
            let response = try await sut.netWorkManager.request(endpoint: .getCarList, parameters: nil, responseType: Car.self)
            switch response {
                
            case .success(result: let result):
                XCTAssertNotNil(result)
                expectation.fulfill()
            case .failure(error: _): break
                
            }
        } catch {
            
        }
        
        await self.waitForExpectations(timeout: 5)
    }
    
    func testCarWebService_WhenGiveFail() async throws {
        let expectation = self.expectation(description: "Fail")
        
        do {
            let response = try await sut.netWorkManager.request(endpoint: .none, parameters: nil, responseType: Car.self)
            switch response {
                
            case .success(result: _): break
                
            case .failure(error: let errorMessage):
                XCTAssertNotNil(errorMessage)
                expectation.fulfill()
            }
        } catch {
        }
        
        await self.waitForExpectations(timeout: 5)
    }
    
    func testCarDetailPushed_Called() {
        let carData = Content(id: 119302,
                              title: "Q7 - Greatness starts, when you don\'t stop.",
                              dateTime: "25.05.2018 14:13",
                              tags: [],
                              content: [],
                              ingress: "The Audi Q7 is the result of an ambitious idea: never cease to improve.",
                              image: "https://www.apphusetreach.no/sites/default/files/audi_q7.jpg",
                              created: 1511968425,
                              changed: 1534311497)
        let isPushed: ()?  = sut.carListCoordinator?.gotoCarDetailScreen(carData: carData)
        XCTAssertNotNil(isPushed)
    }
    
}
