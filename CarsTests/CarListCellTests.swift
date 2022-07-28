//
//  CarListCellTests.swift
//  CarsTests
//
//  Created by raviseta on 19/07/22.
//

import XCTest
@testable import Cars

class CarListCellTests: XCTestCase {

    let tableView = UITableView()
    
    override func setUpWithError() throws {
        super.setUp()
    }
    
    override func tearDownWithError() throws {
        
        super.tearDown()
    }
    
    func testCellUpdateProperties() {
        self.tableView.register(CarListTableCell.className)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CarListTableCell.className, for: IndexPath.init(row: 0, section: 0)) as? CarListTableCell
        else { fatalError(ErrorMessage.XIBnotFound.rawValue) }
        XCTAssertNotNil(cell)
    }
    
}
