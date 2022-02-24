//
//  File.swift
//  
//
//  Created by Cem Nisan on 13.02.2022.
//

import Vapor

final class ListResponse<T>: Content where T: Content {
    let result: T
    let statusCode: HTTPStatus
    
    init(result: T, statusCode: HTTPStatus) {
        self.result = result
        self.statusCode = statusCode
    }
}
