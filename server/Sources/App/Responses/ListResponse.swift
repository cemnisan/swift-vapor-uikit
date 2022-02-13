//
//  File.swift
//  
//
//  Created by Cem Nisan on 13.02.2022.
//

import Vapor

final class ListResponse<T>: Content where T: Content {
    let results: T
    let statusCode: HTTPStatus
    
    init(results: T, statusCode: HTTPStatus) {
        self.results = results
        self.statusCode = statusCode
    }
}
