//
//  APIURLTests.swift
//  CarsTests
//
//  Created by raviseta on 19/07/22.
//

import XCTest
@testable import Cars

class APIURLTests: XCTestCase {
    
    override func setUpWithError() throws {
        super.setUp()
    }
    
    override func tearDownWithError() throws {
        super.tearDown()
    }
    
    func testgetCarURL() throws {
        let url = APIURL.getCarList.getURL()
        XCTAssertEqual(url, "https://www.apphusetreach.no/application/119267/article/get_articles_list")
    }
    
}
