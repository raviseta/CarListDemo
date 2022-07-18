//
//  CarListViewModelTests.swift
//  CarsTests
//
//  Created by raviseta on 19/07/22.
//

import XCTest
@testable import Cars

class CarListViewModelTests: XCTestCase {

    var sut: CarListViewModel!
    let navigationController = UINavigationController()
    var mockAPIService = CarListMockService()
    
    override func setUp() {
        super.setUp()
       let carListCoordinator = CarListCoordinator(navigationController: navigationController)
        sut = CarListViewModel(carListService: mockAPIService, carListCoordinator: carListCoordinator)
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testCarArrayForSuccessResponse() throws {
      
        let expect = expectation(description: "Car list Success")
        self.sut.getCarList()
        expect.fulfill()
        waitForExpectations(timeout: 5)
        
    }
    
    func testCarArrayForError() {
        
        mockAPIService.response = .error
        let expect = expectation(description: "API Invalid Response")
        self.sut.getCarList()
        expect.fulfill()
        waitForExpectations(timeout: 5)
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
