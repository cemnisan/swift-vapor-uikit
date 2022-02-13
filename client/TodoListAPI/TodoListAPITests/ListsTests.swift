//
//  ListsTests.swift
//  TodoListAPITests
//
//  Created by Cem Nisan on 11.02.2022.
//

import XCTest
@testable import TodoListAPI

class ListsTests: XCTestCase {
    func testParsing() throws {
        let bundle = Bundle(for: ListsTests.self)
        let url = bundle.url(forResource: "list", withExtension: "json")!
        let data = try Data(contentsOf: url)
        let decoder = JSONDecoder()
        let list = try decoder.decode(List.self, from: data)
        
        XCTAssertEqual(list.title, "testing3")
        XCTAssertEqual(list.content, "testing3")
        XCTAssertEqual(list.id, UUID(uuidString: "4B0B0FED-8A1A-4DFF-9711-2C81E2A95BE2"))
    }
}
