//
//  ListClient.swift
//  TodoListAPI
//
//  Created by Cem Nisan on 11.02.2022.
//

import Foundation
import Alamofire

public protocol ListClientProtocol {
    func fetchAllLists(completion: @escaping (Result<ListResponse>) -> Void)
}

public final class ListClient: ListClientProtocol {
    public enum Error: Swift.Error {
        case serializationError(internal: Swift.Error)
        case networkError(internal: Swift.Error)
    }
    
    public init() { }
    
    public func fetchAllLists(completion: @escaping (Result<ListResponse>) -> Void) {
//        http://localhost:8080/api/v1/list
        let urlString = "http://localhost:8080/api/v1/list"
        AF.request(urlString).responseData { response in
            switch response.result {
            case .success(let data):
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(ListResponse.self, from: data)
                    completion(.success(response))
                } catch {
                    completion(.failure(Error.serializationError(internal: error)))
                }
            case .failure(let error):
                completion(.failure(Error.networkError(internal: error)))
            }
        }
    }
}
