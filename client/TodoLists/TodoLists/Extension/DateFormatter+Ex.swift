//
//  DateFormatter+Ex.swift
//  TodoLists
//
//  Created by Cem Nisan on 26.02.2022.
//

import Foundation

extension DateFormatter
{
    static let dateOnly: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy"
        return formatter
    }()
    
    static func string(iso string: Date) -> String {
        return DateFormatter.dateOnly.string(from: string)
    }
}
