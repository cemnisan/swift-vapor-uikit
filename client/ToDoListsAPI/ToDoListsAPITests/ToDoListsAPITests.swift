//
//  ToDoListsAPITests.swift
//  ToDoListsAPITests
//
//  Created by Cem Nisan on 13.02.2022.
//

import XCTest
@testable import ToDoListsAPI

class ToDoListsAPITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        let ex = Ex()
        
        ex.sayHello()
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
