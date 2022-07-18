//
//  CarDetailViewTests.swift
//  CarsTests
//
//  Created by raviseta on 14/07/22.
//

import XCTest
import WebKit
@testable import Cars

class CarDetailViewTests: XCTestCase {
    
    var sut: CarDetailViewModel!
    var webViewExpectation: XCTestExpectation!
    
    override func setUp() {
        super.setUp()
        let carData = Content(id: 119302,
                              title: "Q7 - Greatness starts, when you don\'t stop.",
                              dateTime: "25.05.2018 14:13",
                              tags: [],
                              content: [],
                              ingress: "The Audi Q7 is the result of an ambitious idea: never cease to improve.",
                              image: "https://www.apphusetreach.no/sites/default/files/audi_q7.jpg",
                              created: 1511968425,
                              changed: 1534311497)
        sut = CarDetailViewModel(carData: carData)
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func testExample() throws {
        let webView = WKWebView()
        webView.navigationDelegate = self
        webViewExpectation = expectation(description: "Load Image")
        if let request = sut.loadImageInWebView() {
            XCTAssertNotNil(request)
            webView.load(request)
        }
        wait(for: [webViewExpectation], timeout: 5)
    }
    
    func testFailCase() throws {
        
        let carData = Content(id: 119302,
                              title: "Q7 - Greatness starts, when you don\'t stop.",
                              dateTime: "25.05.2018 14:13",
                              tags: [],
                              content: [],
                              ingress: "The Audi Q7 is the result of an ambitious idea: never cease to improve.",
                              image: "",
                              created: 1511968425,
                              changed: 1534311497)
        sut = CarDetailViewModel(carData: carData)
        
        let webView = WKWebView()
        webView.navigationDelegate = self
        let request = sut.loadImageInWebView()
        XCTAssertNil(request)
    }
    
    func testJailBroken_fail() {
        let isJailBroken = UIDevice.current.isJailBroken
           XCTAssertFalse(isJailBroken)
    }
    
}

extension CarDetailViewTests: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        webViewExpectation.fulfill()
    }
}
