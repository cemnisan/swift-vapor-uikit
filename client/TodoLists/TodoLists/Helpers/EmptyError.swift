//
//  EmptyError.swift
//  TodoLists
//
//  Created by Cem Nisan on 26.02.2022.
//

import Foundation

enum EmptyError: Error {
    case isTitleEmpty
    case isContentEmpty
    case isDateEmpty
}
