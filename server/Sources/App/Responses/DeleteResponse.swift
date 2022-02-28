//
//  File.swift
//  
//
//  Created by Cem Nisan on 28.02.2022.
//

import Vapor

struct DeleteResponse: Content
{
    let result: String
    let statusCode: HTTPStatus
    
    init(
        result: String,
        statusCode: HTTPStatus
    ) {
        self.result = result
        self.statusCode = statusCode
    }
}
