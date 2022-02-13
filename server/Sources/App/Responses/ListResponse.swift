//
//  File.swift
//  
//
//  Created by Cem Nisan on 13.02.2022.
//

import Vapor

final class ListResponse<T>: Content where T: Content {
    let results: T
    
    init(results: T) {
        self.results = results
    }
}
