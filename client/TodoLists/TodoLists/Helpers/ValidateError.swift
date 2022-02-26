//
//  EmptyError.swift
//  TodoLists
//
//  Created by Cem Nisan on 26.02.2022.
//

import Foundation

enum ValidateError: Error {
    case isTitleEmpty
    case isTitleTooShort
    case isTitleTooLong
    case isContentEmpty
    case isContentTooShort
    case isDateEmpty
}
