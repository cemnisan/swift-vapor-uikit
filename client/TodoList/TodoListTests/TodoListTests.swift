//
//  TodoListTests.swift
//  TodoListTests
//
//  Created by Cem Nisan on 10.02.2022.
//

import XCTest
@testable import TodoList

class TodoListTests: XCTestCase {

    private var view: MockView!
    private var viewModel: ListViewModelProtocol!
    private var service: MockListService!
    
    override func setUpWithError() throws {
        service = MockListService()
        viewModel = ListViewModel(service: service)
        view = MockView()
        viewModel.delegate = view
    }

    func testExample() throws {
        // Given:
        let list = try ResourceLoader.loadList(resource: .list)
        let list1 = try ResourceLoader.loadList(resource: .list1)
        service.lists = [list, list1]
        
        // When:
        viewModel.load()
        
        // Then:
        XCTAssertEqual(view.outputs.count, 4)
        
        switch try view.outputs.element(at: 0) {
        case .updateTitle(_):
            break
        default:
            XCTFail("First output should be updateTitle.")
        }
        
        XCTAssertEqual(try view.outputs.element(at: 1), .setLoading(true))
        XCTAssertEqual(try view.outputs.element(at: 2), .setLoading(false))
        
        let expectedList = [list, list1].map( { ListPresentation(title: $0.title, content: $0.content)})
        XCTAssertEqual(try view.outputs.element(at: 3), .showList(expectedList))
    }
}

extension Array {
    struct IndexOutOfBoundsError: Error { }
    
    func element(at index: Int) throws -> Element {
        guard index >= 0 && index < self.count else {
            throw IndexOutOfBoundsError()
        }
        return self[index]
    }
}

private class MockView: ListViewModelDelegate {
    var outputs: [ListViewModelOutput] = []
    
    func handleViewModelOutput(_ output: ListViewModelOutput) {
        outputs.append(output)
    }
}
