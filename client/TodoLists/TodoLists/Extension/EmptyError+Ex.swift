//
//  EmptyError+Ex.swift
//  TodoLists
//
//  Created by Cem Nisan on 26.02.2022.
//

import Foundation

extension ValidateError: LocalizedError
{
    var errorDescription: String? {
        switch self {
        case .isTitleEmpty:
            return NSLocalizedString("Title alanı boş bırakılamaz", comment: "")
        case .isTitleTooLong:
            return NSLocalizedString("Title \(15) harften büyük olmalıdır.", comment: "")
        case .isTitleTooShort:
            return NSLocalizedString("Title \(3) harften küçük olmamalıdır.", comment: "")
        case .isContentEmpty:
            return NSLocalizedString("Content alanı boş bırakılamaz", comment: "")
        case .isContentTooShort:
            return NSLocalizedString("Content alanı \(3) harften küçük olmamalıdır.", comment: "")
        case .isDateEmpty:
            return NSLocalizedString("Date alanı boş bırakılamaz.", comment: "")
        }
    }
}
