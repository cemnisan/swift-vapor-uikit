//
//  NetworkRouter.swift
//  ToDoListsAPI
//
//  Created by Cem Nisan on 13.02.2022.
//

import Foundation
import Alamofire

public enum NetworkRouter: URLRequestConvertible {
    case allLists
    case deleteList(id: UUID)
    case updateList(id: UUID)
    
    private var method: HTTPMethod {
        switch self {
        case .allLists:
            return .get
        case .deleteList:
            return .delete
        case .updateList:
            return .put
        }
    }
    
    private var path: String {
        switch self {
        case .allLists:
            return "/list"
        case .updateList(let id):
            return "/list/\(id)"
        case .deleteList(let id):
            return "/list/\(id)"
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .allLists, .deleteList, .updateList:
            return nil
        }
    }
    
    private var baseURL: String {
        return "http://localhost:8080/api/v1"
    }
    
    public func asURLRequest() throws -> URLRequest {
        let url = try baseURL.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        urlRequest.httpMethod = method.rawValue
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let parameters = parameters {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }
        
        return urlRequest
    }
}
