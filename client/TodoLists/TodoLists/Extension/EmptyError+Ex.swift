//
//  EmptyError+Ex.swift
//  TodoLists
//
//  Created by Cem Nisan on 26.02.2022.
//

import Foundation

extension EmptyError: LocalizedError
{
    var errorDescription: String? {
        switch self {
        case .isTitleEmpty:
            return NSLocalizedString("Title alanı boş bırakılamaz", comment: "")
        case .isContentEmpty:
            return NSLocalizedString("Content alanı boş bırakılamaz", comment: "")
        case .isDateEmpty:
            return NSLocalizedString("Date alanı boş bırakılamaz.", comment: "")
        }
    }
}
