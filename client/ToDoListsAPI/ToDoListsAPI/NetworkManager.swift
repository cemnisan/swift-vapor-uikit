//
//  NetworkManager.swift
//  ToDoListsAPI
//
//  Created by Cem Nisan on 13.02.2022.
//

import Foundation
import Alamofire

public final class NetworkManager {
    public static let shared = NetworkManager()
    
    private init() {}
}

extension NetworkManager {
    public func request<T: Codable>(
        request: NetworkRouter,
        responseModel: T.Type,
        completion: @escaping (Result<T>) -> Void
    ) {
        do {
            let urlRequest = try request.asURLRequest()
            AF.request(urlRequest).responseData { (response) in
                switch response.result {
                case .success(let data):
                    let decoder = JSONDecoder()
                    do {
                        let successRes = try decoder.decode(responseModel, from: data)

                        completion(.success(successRes))
                    } catch {
                        completion(.failure(error))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        } catch {
            completion(.failure(error))
        }
    }
}
