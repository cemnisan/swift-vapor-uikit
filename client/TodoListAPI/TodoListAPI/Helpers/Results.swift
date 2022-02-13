//
//  Results.swift
//  TodoListAPI
//
//  Created by Cem Nisan on 11.02.2022.
//

import Foundation

public enum Result<Value> {
    case success(Value)
    case failure(Error)
}
