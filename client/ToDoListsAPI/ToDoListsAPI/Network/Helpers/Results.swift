//
//  Results.swift
//  ToDoListsAPI
//
//  Created by Cem Nisan on 13.02.2022.
//

import Foundation

public enum Result<Value> {
    case success(Value)
    case failure(Error)
}
