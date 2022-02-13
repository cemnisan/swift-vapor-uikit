//
//  ResourceLoader.swift
//  TodoList
//
//  Created by Cem Nisan on 12.02.2022.
//

import Foundation
import TodoListAPI

final class ResourceLoader {
    enum ListResource: String {
        case list
        case list1
    }
    
    static func loadList(resource: ListResource) throws -> List {
        let bundle = Bundle.test
        let url = bundle.url(forResource: resource.rawValue, withExtension: "json")
        let data = try Data(contentsOf: url!)
        let decoder = JSONDecoder()
        let list = try decoder.decode(List.self, from: data)
        
        return list
    }
}

private extension Bundle {
    class Dummy { }
    
    static let test = Bundle(for: Dummy.self)
}
